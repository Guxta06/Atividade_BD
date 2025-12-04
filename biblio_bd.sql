-- Inicio

CREATE DATABASE biblioteca_bd;
SET FOREIGN_KEY_CHECKS = 1;
USE biblioteca_bd;
-- 1)Criação das tabelas 


-- Tabela: autor
CREATE TABLE autor (
  autor_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
);


-- Tabela: livro
CREATE TABLE livro (
    livro_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor_id INT,
    FOREIGN KEY (autor_id)
        REFERENCES autor(autor_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ;


-- Tabela: cliente
CREATE TABLE cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);


-- Tabela: emprestimo
CREATE TABLE emprestimo (
    emprestimo_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    livro_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    status ENUM('Emprestado','Devolvido','Atrasado') DEFAULT 'Emprestado',
    FOREIGN KEY (cliente_id)
        REFERENCES cliente(cliente_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (livro_id)
        REFERENCES livro(livro_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_cliente(cliente_id),
    INDEX idx_livro(livro_id)
);



-- 2)inserção de dados de exemplo (população do banco)

-- Autores
INSERT INTO autor (nome) VALUES
('Machado de Assis'),
('George Orwell'),
('Clarice Lispector');

-- Livros
INSERT INTO livro (titulo, autor_id) VALUES
('Dom Casmurro', 1),
('1984', 2),
('A Hora da Estrela', 3),
('Animal Farm', 2);

-- Clientes
INSERT INTO cliente (nome, email) VALUES
('Ana Pereira', 'ana.pereira@example.com'),
('Bruno Silva', 'bruno.silva@example.com'),
('Carla Souza', 'carla.souza@example.com');

-- Empréstimos de exemplo
INSERT INTO emprestimo (cliente_id, livro_id, data_emprestimo, data_devolucao, status)
VALUES
(1, 1, '2025-11-25', '2025-12-02', 'Emprestado'),
(2, 2, '2025-11-28', '2025-12-05', 'Emprestado');

-- 3) SELECTs 

-- 3.1 Listar todos os autores
SELECT * FROM autor ORDER BY autor_id;

-- 3.2 Listar todos os livros com autor
SELECT l.livro_id, l.titulo, a.autor_id, a.nome AS autor_nome
FROM livro l
LEFT JOIN autor a ON a.autor_id = l.autor_id
ORDER BY l.titulo;

-- 3.3 Listar todos os clientes
SELECT * FROM cliente ORDER BY cliente_id;

-- 3.4 Listar empréstimos (com cliente e livro)
SELECT e.emprestimo_id, c.cliente_id, c.nome AS cliente, l.livro_id, l.titulo AS livro,
       e.data_emprestimo, e.data_devolucao, e.status
FROM emprestimo e
LEFT JOIN cliente c ON c.cliente_id = e.cliente_id
LEFT JOIN livro l ON l.livro_id = e.livro_id
ORDER BY e.data_emprestimo DESC;

-- 3.5 Histórico de empréstimos por cliente (ex.: cliente_id = 1)
SELECT e.emprestimo_id, l.titulo, e.data_emprestimo, e.data_devolucao, e.status
FROM emprestimo e
JOIN livro l ON l.livro_id = e.livro_id
WHERE e.cliente_id = 1
ORDER BY e.data_emprestimo DESC;


-- 4) UPDATEs / Manipulação de dados 

-- 4.1 Registrar devolução: marcar empréstimo como 'Devolvido' e definir data (exemplo: emprestimo_id = 1)
UPDATE emprestimo
SET status = 'Devolvido', data_devolucao = COALESCE(data_devolucao, CURDATE())
WHERE emprestimo_id = 1 AND status <> 'Devolvido';

-- 4.2 Inserir um novo empréstimo (exemplo prático)
INSERT INTO emprestimo (cliente_id, livro_id, data_emprestimo, data_devolucao, status)
VALUES (3, 3, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Emprestado');

-- 4.3 Atualizar dados de cliente (ex.: corrigir e-mail)
UPDATE cliente
SET email = 'ana.pereira@novoemail.com'
WHERE cliente_id = 1;


-- 6) SHOWs para verificar a estrutura 
SHOW TABLES;
SHOW CREATE TABLE autor;
SHOW CREATE TABLE livro;
SHOW CREATE TABLE cliente;
SHOW CREATE TABLE emprestimo;
