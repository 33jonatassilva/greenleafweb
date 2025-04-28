import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, String>> notifications = [
    {
      'title': 'Novo serviço disponível',
      'message': 'Um novo serviço na sua área foi publicado',
      'time': '10 min atrás',
      'read': 'false',
    },
    {
      'title': 'Pagamento confirmado',
      'message': 'Seu pagamento foi processado com sucesso',
      'time': '1 hora atrás',
      'read': 'false',
    },
    {
      'title': 'Atualização do sistema',
      'message': 'Nova versão do app disponível',
      'time': 'Ontem',
      'read': 'true',
    },
    {
      'title': 'Bem-vindo!',
      'message': 'Obrigado por se cadastrar em nosso app',
      'time': '2 dias atrás',
      'read': 'true',
    },
  ];

  void _markAllAsRead() {
    setState(() {
      notifications = notifications.map((notification) {
        return {...notification, 'read': 'true'};
      }).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todas as notificações foram marcadas como lidas'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _removeNotification(int index) {
    final removedNotification = notifications[index];
    setState(() {
      notifications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notificação "${removedNotification['title']}" removida'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              notifications.insert(index, removedNotification);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Marcar todas como lidas',
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off, size: 50, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma notificação',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification['read'] == 'true';

                return Dismissible(
                  key: Key(notification['title']!),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) => _removeNotification(index),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kIsWeb ? 20 : 10, vertical: 5),
                    color: isRead ? Colors.grey[50] : Colors.blue[50],
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(
                        isRead ? Icons.notifications_none : Icons.notifications,
                        color: isRead ? Colors.grey : Colors.blue,
                      ),
                      title: Text(
                        notification['title']!,
                        style: TextStyle(
                          fontWeight:
                              isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification['message']!),
                          const SizedBox(height: 4),
                          Text(
                            notification['time']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isRead ? Colors.grey : Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => _removeNotification(index),
                      ),
                      onTap: () {
                        if (!isRead) {
                          setState(() {
                            notifications[index]['read'] = 'true';
                          });
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}