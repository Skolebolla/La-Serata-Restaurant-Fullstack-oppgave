DROP TABLE IF EXISTS bord_bestillinger CASCADE;
DROP TABLE IF EXISTS rett_har_allergi CASCADE;
DROP TABLE IF EXISTS allergier CASCADE;
DROP TABLE IF EXISTS meny CASCADE;

CREATE TABLE meny (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rett VARCHAR(100) NOT NULL,
    pris DECIMAL(10,2) NOT NULL,
    beskrivelse TEXT,
    kategori VARCHAR(50)
);

CREATE TABLE bord_bestillinger (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fornavn VARCHAR(100) NOT NULL,
    etternavn VARCHAR(100) NOT NULL,
    tlf INTEGER NOT NULL,
    epost VARCHAR(100) NOT NULL,
    antall_personer INTEGER NOT NULL,
    dato DATE NOT NULL,
    klokkeslett TIME NOT NULL,
    kommentar TEXT
);

CREATE TABLE allergier (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    navn VARCHAR(100) NOT NULL
);

CREATE TABLE rett_har_allergi (
    rett_id INTEGER NOT NULL,
    allergi_id INTEGER NOT NULL,
    PRIMARY KEY (rett_id, allergi_id),
    FOREIGN KEY (rett_id) REFERENCES meny(id),
    FOREIGN KEY (allergi_id) REFERENCES allergier(id)
);

INSERT INTO allergier (navn)
VALUES
    ('Gluten'),
    ('Laktose'),
    ('Nøtter'),
    ('Sulfitter'),
    ('Fisk'),
    ('Skalldyr');

INSERT INTO meny (rett, pris, beskrivelse, kategori)
VALUES
    ('Pizza', 129.00, 'Digg pizza med ost og skinke', 'Hovedrett'),
    ('Pasta', 99.00, 'Kremet pasta med sopp og fløte', 'Hovedrett'),
    ('Salat', 79.00, 'Frisk salat med pinjekjerner og fetaost', 'Forrett'),
    ('Burger', 119.00, 'Saftig burger med pommes frites', 'Hovedrett'),
    ('Sushi', 149.00, 'Fersk sushi med laks og avokado', 'Hovedrett'),
    ('Taco', 89.00, 'Smaksrik taco med ekte meksikansk krydder', 'Hovedrett');

INSERT INTO rett_har_allergi (rett_id, allergi_id)
VALUES
    (1, 1), -- Pizza har Gluten
    (1, 2), -- Pizza har Laktose
    (2, 1), -- Pasta har Gluten
    (2, 2), -- Pasta har Laktose
    (3, 3), -- Salat har Nøtter
    (5, 5), -- Sushi har Fisk
    (5, 6); -- Sushi har Skalldyr

INSERT INTO bord_bestillinger (fornavn, etternavn, tlf, epost, antall_personer, dato, klokkeslett, kommentar)
VALUES
    ('Ola', 'Nordmann', 12345678, 'olanordmann@gmail.no', 4, '2024-07-15', '19:00', 'Sønnen min liker ikke støy, så et rolig bord hvis mulig'),
    ('Kari', 'Nordkvinne', 87654321, 'karinordkvinne@gmail.no', 2, '2024-07-16', '20:00', 'Vegetarisk mat'),
    ('Per', 'Hansen', 23456789, 'perhansen@icloud.com', 6, '2024-07-17', '18:30', 'Barn med allergi mot nøtter'),
    ('Lise', 'Olsen', 98765432, 'liseolsen@outlook.com', 3, '2024-07-18', '19:30', 'Bord med utsikt hvis mulig'),
    ('Mona', 'Larsen', 34567890, 'monalarsen@icloud.com', 5, '2024-07-19', '20:00', 'Feirer bursdag');

SELECT * FROM meny ORDER BY pris;
SELECT * FROM bord_bestillinger ORDER BY dato;

-- Finn alle retter som inneholder gluten:
SELECT m.rett, m.pris
FROM meny m
JOIN rett_har_allergi rha ON m.id = rha.rett_id
JOIN allergier a ON a.id = rha.allergi_id
WHERE a.navn = 'Gluten';
