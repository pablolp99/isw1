Usuario válido con tarjeta válida
-User: validUser
-Password: validUserPassword

Usuario válido con tarjeta vencida
-User: validUserInvalidCard
-Password: validUserPassword

Cualquier otro usuario es invalido.

Levantar server
server := TusLibrosServerRestInterface listeningOn: 8080   

Abrir ventana login
TusLibrosClientLogInWindow open 
