import 'package:flutter/material.dart';
import 'package:vinnerenflix/info/info_view.dart';
import 'package:vinnerenflix/movies/movies_view.dart';
import 'package:vinnerenflix/search/search_view.dart';

import 'home_navigation_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final _controller = TextEditingController();
  static final _widgetOptions = [MoviesView(), InfoView()];
  final List<HomeItem> _items = <HomeItem>[
    HomeItem(
        iconAssetPath: 'assets/icon_tab_movies.png',
        iconAssetPathSelected: 'assets/icon_tab_movies_selected.png',
        isActive: true),
    HomeItem(
        iconAssetPath: 'assets/icon_tab_info.png',
        iconAssetPathSelected: 'assets/icon_tab_info_selected.png',
        isActive: false),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      for (var item in _items) {
        item.isActive = false;
      }
      _items[index].isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {    

    return Scaffold(      
      appBar: _selectedIndex != 1 ? _buildAppBar() : null,
      bottomNavigationBar: _buildNavigationBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
    );
  }

  BottomNavigationBar _buildNavigationBar() {
    return BottomNavigationBar(
      items: [
        _menuItem(_items[0]),
        _menuItem(_items[1]),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _menuItem(HomeItem item) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        child: Column(
          children: [
            Container(
              width: 30,
              height: 30,
              child: item.isActive
                  ? Image.asset(item.iconAssetPathSelected)
                  : Image.asset(item.iconAssetPath),
            ),
          ],
        ),
      ),
      label: '',
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          child: Row(
            children: [
              _buildIcon(),
              const SizedBox(
                width: 20,
              ),
              _buildSearchField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SizedBox(
      height: 30,
      child: Image.asset('assets/icon.png'),
    );
  }

  Widget _buildSearchField() {
    
    return Expanded(
      child: TextField(
        controller: _controller,
        autofocus: false,        
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: 'Buscar película',
          suffix: GestureDetector(
            onTap: () {
              print('Empty ${_controller.text.isEmpty} ');
              if(_controller.text.isEmpty){
                _showMyDialog();
              }else{
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SearchView(
                    query: _controller.text,
                  ),
                ));
              }              
            },
            child: Text(
              'Buscar',
              style: TextStyle(color: Color.fromRGBO(0, 94, 255, 1)),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Información'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Por favor escribe el nombre de la película que quieres buscar.'),              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Entendido'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
