import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/features/dog_info/presentation/providers/dog_info_notifier.dart';

class DogInfoPage extends ConsumerWidget {
  DogInfoPage({super.key});

  final TextEditingController breedController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogInfo = ref.watch(dogInfoNotifierProvider);
    final dogInfoNotifier = ref.read(dogInfoNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Info')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            dogInfo.when(
              data: (data) => Column(
                key: const Key('dog_info_displayed'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data.imageUrl),
                  Center(
                    child: Text(
                      data.breed,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      data.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => const Text('Something went wrong'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: breedController,
                decoration: const InputDecoration(
                  hintText: 'Enter breed',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  key: const Key('get_dog_info_button'),
                  onPressed: () {
                    dogInfoNotifier.getSpecificDogInfo(breedController.text);
                    breedController.clear();
                  },
                  child: const Text('Get Dog Info'),
                ),
                ElevatedButton(
                  key: const Key('get_random_dog_info_button'),
                  onPressed: () {
                    dogInfoNotifier.getRandomDogInfo();
                  },
                  child: const Text('Get Random Dog Info'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
