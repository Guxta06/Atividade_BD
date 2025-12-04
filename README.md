# Atividade_BD

Logs do Mysql Workbench - Criação de tabelas

22:15:11	SET FOREIGN_KEY_CHECKS = 1	0 row(s) affected	0.000 sec

22:15:32	USE biblioteca_bd	0 row(s) affected	0.000 sec

22:15:35	CREATE TABLE autor (   autor_id INT AUTO_INCREMENT PRIMARY KEY,   nome VARCHAR(100) NOT NULL )	0 row(s) affected	0.047 sec

22:15:40	CREATE TABLE livro (     livro_id INT AUTO_INCREMENT PRIMARY KEY,     titulo VARCHAR(200) NOT NULL,     autor_id INT,     FOREIGN KEY (autor_id)         REFERENCES autor(autor_id)         ON DELETE RESTRICT         ON UPDATE CASCADE )	0 row(s) affected	0.046 sec

22:15:45	CREATE TABLE cliente (     cliente_id INT AUTO_INCREMENT PRIMARY KEY,     nome VARCHAR(100) NOT NULL,     email VARCHAR(100) )	0 row(s) affected	0.031 sec

22:30:50	CREATE TABLE emprestimo ( emprestimo_id INT AUTO_INCREMENT PRIMARY KEY, cliente_id INT, livro_id INT, data_emprestimo DATE, data_devolucao DATE, status ENUM('Emprestado','Devolvido','Atrasado') DEFAULT 'Emprestado', FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (livro_id) REFERENCES livro(livro_id) ON DELETE RESTRICT ON UPDATE CASCADE, INDEX idx_cliente(cliente_id), INDEX idx_livro(livro_id))	0 row(s) affected	0.031 sec

Logs do Mysql Workbench - Inserts de exemplo

22:31:25	INSERT INTO autor (nome) VALUES
 ('Machado de Assis'),
 ('George Orwell'),
 ('Clarice Lispector')	3 row(s) affected
 Records: 3  Duplicates: 0  Warnings: 0	0.015 sec
 
22:31:31	INSERT INTO livro (titulo, autor_id) VALUES
 ('Dom Casmurro', 1),
 ('1984', 2),
 ('A Hora da Estrela', 3),
 ('Animal Farm', 2)	4 row(s) affected
 Records: 4  Duplicates: 0  Warnings: 0	0.016 sec
 
22:31:46	INSERT INTO cliente (nome, email) VALUES
 ('Ana Pereira', 'ana.pereira@example.com'),
 ('Bruno Silva', 'bruno.silva@example.com'),
 ('Carla Souza', 'carla.souza@example.com')	3 row(s) affected
 Records: 3  Duplicates: 0  Warnings: 0	0.015 sec
 
22:32:02	INSERT INTO emprestimo (cliente_id, livro_id, data_emprestimo, data_devolucao, status)
 VALUES
 (1, 1, '2025-11-25', '2025-12-02', 'Emprestado'),
 (2, 2, '2025-11-28', '2025-12-05', 'Emprestado')	2 row(s) affected
 Records: 2  Duplicates: 0  Warnings: 0	0.000 sec

 Logs do Mysql Workbench - SELECTs
 
 *Listar todos os autores
 
 <img width="1066" height="679" alt="image" src="https://github.com/user-attachments/assets/243f91e3-f641-4ecc-aea9-15160f501d90" />

 *Listar todos os livros com autor
 
 <img width="997" height="819" alt="image" src="https://github.com/user-attachments/assets/e74e2584-e7f7-4e8c-839f-be6cddb7c6b0" />

 *Listar todos os clientes
 
 <img width="985" height="842" alt="image" src="https://github.com/user-attachments/assets/c727cf79-9c03-48c1-8398-e601e3179b46" />

 *Listar empréstimos (com cliente e livro)
 
 <img width="1018" height="829" alt="image" src="https://github.com/user-attachments/assets/3f3e977b-89e1-4072-98b1-b997a44b3bc4" />

 *Histórico de empréstimos por cliente (ex.: cliente_id = 1)
 
 <img width="975" height="835" alt="image" src="https://github.com/user-attachments/assets/835a546e-eb2c-4d8e-b76b-01713ac1a922" />

  Logs do Mysql Workbench - UPDATEs
- Registrar devolução: marcar empréstimo como 'Devolvido' e definir data (exemplo: emprestimo_id = 1)
  
22:44:13	UPDATE emprestimo
 SET status = 'Devolvido', data_devolucao = COALESCE(data_devolucao, CURDATE())
 WHERE emprestimo_id = 1 AND status <> 'Devolvido'	1 row(s) affected
 Rows matched: 1  Changed: 1  Warnings: 0	0.016 sec
 
-Inserir um novo empréstimo

22:44:18	INSERT INTO emprestimo (cliente_id, livro_id, data_emprestimo, data_devolucao, status)
 VALUES (3, 3, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Emprestado')	1 row(s) affected	0.000 sec

-Atualizar dados de cliente (ex.: corrigir e-mail)

22:44:21	UPDATE cliente
 SET email = 'ana.pereira@novoemail.com'
 WHERE cliente_id = 1	1 row(s) affected
 Rows matched: 1  Changed: 1  Warnings: 0	0.016 sec


SHOWs para verificar a estrutura 

Show tables - 
<img width="952" height="628" alt="image" src="https://github.com/user-attachments/assets/b99013d7-9fff-4f28-a1fc-19802851edce" />

Show create table autor - 
<img width="1337" height="665" alt="image" src="https://github.com/user-attachments/assets/2ccba559-208b-486c-b4c7-aad79312c284" />

Show create table Livro - 
<img width="1416" height="877" alt="image" src="https://github.com/user-attachments/assets/ecb8593a-95fd-4378-b708-6ff6b64fbe0f" />

Show create table cliente - 
<img width="1449" height="888" alt="image" src="https://github.com/user-attachments/assets/ecd72787-cd77-4395-86fb-44df7adfffed" />

Show create table emprestimo - 
<img width="1454" height="927" alt="image" src="https://github.com/user-attachments/assets/8a103fe2-36ff-4a01-a14d-841f71f918d4" />


