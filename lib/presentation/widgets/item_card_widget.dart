import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ItemCardWidget extends StatelessWidget {
  ItemCardWidget({
    super.key,
    required this.index,
    required this.personName,
    required this.onePerson,
    required this.callTime,
  });
  final int index;
  final String personName;
  final CallLogEntry onePerson;
  final String callTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.primaries[index % Colors.primaries.length],
        child: const Icon(Icons.person, size: 32),
      ),
      title: TextWidget(text: personName, fontSize: 17),
      subtitle: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            onePerson.callType.toString() == "CallType.incoming"
                ? Icons.call_received
                : (onePerson.callType.toString() == "CallType.outgoing")
                ? Icons.call_made
                : Icons.call_missed,
            size: 18,
          ),
          TextWidget(text: callTime, fontSize: 16),
        ],
      ),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
    );
  }
}
