import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String baseURL = 'proj2.atwebpages.com';

class Books {
  final String title;
  final String author;
  final String description;
  final String category;

  Books({
    required this.title,
    required this.author,
    required this.description,
    required this.category,
  });

  @override
  String toString() {
    return 'Title: $title\nAuthor: $author\nCategory: $category\nDescription: $description';
  }
}
 List<Books> books = [];

Future<void> fetchBooks(Function(bool) onComplete,
    [String searchQuery = '']) async {
  try {
  print('object');
  books.clear();

  final url = Uri.http(baseURL, "/index.php");
  print(url);
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  });
  if (response.statusCode == 200) {
    final jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse is Map<String, dynamic>) {
      // If it's a map, check if there's a key that contains the list of books
      // For example, assuming the response contains a key called 'books'
      var booksList = jsonResponse['data'];
      if (booksList is List) {
        for (var row in booksList) {
          books.add(Books(
            title: row['title'] ?? '',        // Provide default empty string if null
            author: row['author'] ?? '',      // Provide default empty string if null
            description: row['description'] ?? '',  // Provide default empty string if null
            category: row['category'] ?? '',  
          ));
        }
        onComplete(true);
        print('Books fetched successfully.');
        print(books);
      } else {
        print('Expected a list under "books", but found: $booksList');
        onComplete(false);
      }
    } else {
      print('Expected a map but received: $jsonResponse');
      onComplete(false);
    }
  } else {
    print('Failed to fetch books. Status code: ${response.statusCode}');
    onComplete(false);
  }
  } catch (e) {
    print(e);
    onComplete(false);
  }
}

List<Books> getBooks(String category) {
  List<Books> res = [];
  for (var book_author in books) {
    if (book_author.author.toLowerCase().contains(category.toLowerCase())) {
      res.add(book_author);
    }
  }
  return res;
}
