// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisasterManagementPage extends StatelessWidget {
  final List<QuestionAnswer> faq = [
    QuestionAnswer(
      question: 'How to Prepare for Earthquakes?',
      answer:
          'Earthquake preparedness involves securing heavy furniture, anchoring appliances, creating an emergency kit with food, water, and medical supplies, and practicing "Drop, Cover, and Hold On" drills.',
    ),
    QuestionAnswer(
      question: 'What are the Strategies for Flood Management?',
      answer:
          'Flood management strategies include building flood barriers, constructing drainage systems, implementing zoning regulations, and creating early warning systems.',
    ),
    QuestionAnswer(
      question: 'How to Protect Against Wildfires?',
      answer:
          'To protect against wildfires, create a defensible space around your home, remove flammable vegetation, maintain a clear zone, use fire-resistant materials for construction, and have an evacuation plan.',
    ),
    QuestionAnswer(
      question: 'What are the Techniques for Hurricane Preparedness?',
      answer:
          'Hurricane preparedness techniques include securing windows and doors, reinforcing roofs, trimming trees, stocking up on supplies, and having a designated safe room or shelter.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Awareness'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 22),
              child: const Text(
                'Disaster Management Resources',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: faq.length,
              itemBuilder: (context, index) {
                return _buildQuestionTile(faq[index]);
              },
            ),
            Container(
              height: 13.0,
              color: const Color.fromARGB(255, 194, 193, 193),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.only(left: 22),
              child: const Text(
                'Need More Assistance?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                _launchEmail('your.email@example.com');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 20.0),
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Reach out to us for further assistance.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String toEmail) async {
    String emailUrl = 'mailto:$toEmail';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  Widget _buildQuestionTile(QuestionAnswer questionAnswer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
      child: ExpansionTile(
        title: Row(
          children: [
            const Icon(Icons.question_answer_sharp),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                questionAnswer.question,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 8.0, bottom: 8.0),
            child: Text(questionAnswer.answer),
          ),
        ],
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}
