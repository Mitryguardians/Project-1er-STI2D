import 'package:flutter/material.dart';
import 'package:project_stidd/page/reservation.dart';

class ElevatedBtnToGoNewTicketPage extends StatefulWidget {
  @override
  _ElevatedBtnToGoNewTicketPageState createState() =>
      _ElevatedBtnToGoNewTicketPageState();
}

class _ElevatedBtnToGoNewTicketPageState
    extends State<ElevatedBtnToGoNewTicketPage> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: _isPressed ? Colors.grey : Colors.grey,
              offset: const Offset(0.0, 4.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Reservation(),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.5);
              }
              return Colors.black;
            }),
            elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return 0;
              }
              return 8;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(150.0, 50.0),
            ),
          ),
          child: const Text(
            'Réserver un billet !',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
