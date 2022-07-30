import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/app_colors.dart';
import 'package:ricky_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';
import '../../domain/entities/person_entity.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              person.name,
              style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            SizedBox(
              child: PersonCacheImage(
                height: 260,
                width: 260,
                imageUrl: person.image,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: person.status == 'Alive' ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(width: 8),
                Text(
                  person.status,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                ),
              ],
            ),
            if (person.type.isNotEmpty) ...buildText('Type', person.type),
            ...buildText('Gender:', person.gender),
            ...buildText('Number of episodes:', '${person.episode.length}'),
            ...buildText('Species:', person.species),
            ...buildText('Last known location:', person.location.name),
            ...buildText('Origin:', person.origin.name),
            ...buildText('Was created:', '${person.created}'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String key, String value) {
    return [
      const SizedBox(height: 12),
      Text(key, style: const TextStyle(color: AppColors.greyColor)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(color: Colors.white)),
    ];
  }
}
