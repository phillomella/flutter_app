import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appointments_model.dart';
import 'appointments_entry.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsEntry()),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppointmentsModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.appointments.length,
            itemBuilder: (context, index) {
              final appointment = model.appointments[index];
              return ListTile(
                title: Text(appointment.title),
                subtitle: Text('${appointment.date} ${appointment.time}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentsEntry(appointment: appointment),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    model.deleteAppointment(appointment.id!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
