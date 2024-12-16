import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appointments_model.dart';

class AppointmentsEntry extends StatefulWidget {
  final Appointment? appointment;

  const AppointmentsEntry({super.key, this.appointment});

  @override
  _AppointmentsEntryState createState() => _AppointmentsEntryState();
}

class _AppointmentsEntryState extends State<AppointmentsEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _date;
  late String _time;

  @override
  void initState() {
    super.initState();
    _title = widget.appointment?.title ?? '';
    _description = widget.appointment?.description ?? '';
    _date = widget.appointment?.date ?? '';
    _time = widget.appointment?.time ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null ? 'Add Appointment' : 'Edit Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _date,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _date = value!;
                },
              ),
              TextFormField(
                initialValue: _time,
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  return null;
                },
                onSaved: (value) {
                  _time = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final appointment = Appointment(
                      id: widget.appointment?.id,
                      title: _title,
                      description: _description,
                      date: _date,
                      time: _time,
                    );

                    if (widget.appointment == null) {
                      Provider.of<AppointmentsModel>(context, listen: false).addAppointment(appointment);
                    } else {
                      Provider.of<AppointmentsModel>(context, listen: false).updateAppointment(appointment);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.appointment == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
