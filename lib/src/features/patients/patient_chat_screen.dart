import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class ChatMessage {
  final String text;
  final bool isFromPsychologist;
  final String time;

  ChatMessage({
    required this.text,
    required this.isFromPsychologist,
    required this.time,
  });
}

class PatientChatScreen extends StatefulWidget {
  static const route = '/patient-chat';

  final String? patientName;

  const PatientChatScreen({super.key, this.patientName});

  @override
  State<PatientChatScreen> createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _initializeMessages();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeMessages() {
    // Mensajes simulados basados en la imagen
    messages = [
      ChatMessage(
        text: 'Entiendo. ¿Has probaa...',
        isFromPsychologist: true,
        time: '10:52',
      ),
      ChatMessage(
        text: 'Hoy me sentí muy frustrado...',
        isFromPsychologist: false,
        time: '12:018',
      ),
      ChatMessage(
        text: 'Hom Pepiore',
        isFromPsychologist: false,
        time: '12:018',
      ),
      ChatMessage(
        text: 'Entiendo. ¿Has probaa...',
        isFromPsychologist: true,
        time: '10:50',
      ),
      ChatMessage(
        text: 'No logré terminar la tarea...',
        isFromPsychologist: false,
        time: '2:9 016',
      ),
      ChatMessage(
        text: 'Te sugiero ejercicios de respiración...',
        isFromPsychologist: true,
        time: '10:14',
      ),
      ChatMessage(
        text: 'No logré terminar la tarea...',
        isFromPsychologist: false,
        time: '2:2:125',
      ),
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          text: _messageController.text.trim(),
          isFromPsychologist: true,
          time: TimeOfDay.now().format(context),
        ),
      );
    });

    _messageController.clear();

    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: '',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMessagesList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF334155), Color(0xFF475569)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Mensajes / Diario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return _buildMessageBubble(message);
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            message.isFromPsychologist
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  message.isFromPsychologist
                      ? const Color(0xFF334155)
                      : const Color(0xFF93C5FD),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft:
                    message.isFromPsychologist
                        ? const Radius.circular(4)
                        : const Radius.circular(20),
                bottomRight:
                    message.isFromPsychologist
                        ? const Radius.circular(20)
                        : const Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 16,
                color:
                    message.isFromPsychologist
                        ? Colors.white
                        : const Color(0xFF1F2937),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(
              left: message.isFromPsychologist ? 16 : 0,
              right: message.isFromPsychologist ? 0 : 16,
            ),
            child: Text(
              message.time,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.attach_file, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xFF1F2937)),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
