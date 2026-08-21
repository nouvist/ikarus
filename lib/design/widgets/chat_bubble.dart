import 'package:ikarus/design.dart';

enum ChatBubbleType { user, assistant }

class ChatBubble extends StatelessWidget {
  final ChatBubbleType type;
  const ChatBubble({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return Container(
    //   decoration: BoxDecoration(),
    //   child: Text("lorem ipsum dolor sit amet consectetur"));
  }
}
