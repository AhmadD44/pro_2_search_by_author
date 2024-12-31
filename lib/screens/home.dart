import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/book_details.dart';
import 'package:flutter_application_1/services/workout.dart'; // Make sure this provides fetchBooks and getBooks

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searched = TextEditingController();
  bool _isLoading = true;
  List<Books> _filteredBooks = []; 

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() {
    setState(() {
      _isLoading = true;
    });

    fetchBooks((success) {
      setState(() {
        _isLoading = false;
        _filteredBooks = books; 
      });
      print(_filteredBooks);
    });
  }

  void updateBooks(String author) {
    setState(() {
      _filteredBooks = getBooks(author); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchEvents,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searched,
              decoration: const InputDecoration(
                labelText: 'Search By Author',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  updateBooks(searched.text);
                });
              },
              onSubmitted: (value) => _fetchEvents(),
            ),
          ),
          Expanded(
            child:
                _isLoading
                ? const Center(child: CircularProgressIndicator()) // Loading spinner
                :
                _filteredBooks.isEmpty
                    ? const Center(
                        child: Text("No Book found")) // No results found
                    : ListView.builder(
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          var book = _filteredBooks[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {
                                // Navigate to Event Details Screen (you'll need to define EventDetails screen)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailsScreen(book: book),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(book.author), 
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book.title, 
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            book.description, 
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      
                                    ),
                                    Container(child: Text(book.category),)
                                    // IconButton(
                                    //   icon: const Icon(Icons.arrow_forward),
                                    //   onPressed: () {
                                    //     // Handle event navigation
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => EventDetailsScreen(event: book),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
