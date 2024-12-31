import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/workout.dart';
class BookDetailsScreen extends StatelessWidget {
  final Books book;

  const BookDetailsScreen({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Author: ${book.author}'),
            const SizedBox(height: 8),
            Text('Description: ${book.description}'),
            const SizedBox(height: 8),
            Text('Category: ${book.category}'),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: ()  {
                // _showRegisterDialog(context)
                }
                ,
                child: const Text('Purchase'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRegisterDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Register'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final message = await registerForEvent(
            //       event.id,
            //       nameController.text,
            //       emailController.text,
            //     );
            //     Navigator.of(context).pop();
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            //   },
            //   child: const Text('Submit'),
            // ),
          ],
        );
      },
    );
  }
}
