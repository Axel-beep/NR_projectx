-- =====================================================================
-- The 12 SC Zagreb canteens (source: https://www.sczg.unizg.hr/prehrana,
-- 13.11.2026). Run AFTER the migration, in Supabase -> SQL Editor.
-- Hours change during holidays: update them in Table Editor when needed.
-- =====================================================================
insert into public.canteens
  (sort_order, name, full_name, slug, address, description, opening_hours, thumbnail_url, sc_url, is_open)
values
(1, 'Stjepan Radić', 'Restoran u Studentskom domu Stjepan Radić', 'stjepan-radic',
 'Jarunska ul. 2, Zagreb',
 'Menu obroci, jela po izboru, pizzeria.',
 E'Pon–Čet: Restoran I doručak 07:00–09:30, ručak 11:30–16:00, večera 17:30–21:00; Restoran II ručak 11:00–14:00; pizzeria 14:00–20:30\nPet: doručak 07:00–09:30, ručak 11:00–16:00, večera 17:30–21:00; pizzeria 14:00–20:30\nVikend: doručak 08:00–10:00 (ned. nema), ručak 11:30–16:00, večera 17:30–21:00; pizzeria 11:30–15:00',
 '/canteens/stjepan-radic.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/stjepan-radic-2', true),

(2, 'Cvjetno naselje', 'Restoran u Studentskom domu Cvjetno naselje', 'cvjetno-naselje',
 'Odranska ul. 8, Zagreb',
 'Menu obroci, jela po izboru, caffe bar i slastičarna.',
 E'Pon: linija I 17:30–21:00, linija II 16:00–20:00\nUto–Pet: linija I ručak 11:00–16:00, večera 17:30–21:00; linija II ručak 12:00–15:00, večera 17:30–20:00 (pet. bez večere)\nCaffe bar i slastičarna: pon 16:00–21:00, uto–pet 14:00–21:00',
 '/canteens/cvjetno-naselje.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/cvjetno-naselje-2', true),

(3, 'Lašćina', 'Restoran u Studentskom domu Lašćina', 'lascina',
 'Lašćinska cesta 32, Zagreb',
 'Menu obroci, jela po izboru.',
 E'Pon–Pet: 08:00–20:30\nSub: doručak 08:30–10:00, ručak 11:00–15:00\nNed: zatvoreno',
 '/canteens/lascina.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/lascina', true),

(4, 'Savska (SC)', 'Restoran Savska', 'savska',
 'Savska cesta 25, Zagreb',
 'Menu obroci, jela po izboru, express restoran.',
 E'Pon–Pet: ručak 11:00–15:00 (lijeva linija; desna privremeno ne radi)\nExpress restoran: pon–pet 09:00–15:00\nSub–Ned: zatvoreno',
 '/canteens/savska.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/savska', true),

(5, 'Borongaj', 'Restoran Borongaj', 'borongaj',
 'Borongajska cesta, Zagreb',
 'Menu obroci, jela po izboru, caffe bar.',
 E'Pon–Čet: ručak 10:30–16:00\nPet: ručak 10:30–15:00\nSub–Ned: zatvoreno',
 '/canteens/borongaj.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/borongaj', true),

(6, 'Manducat', 'Restoran Manducat', 'manducat',
 'Ulica Filipa Vukasovića 3, Zagreb',
 'Menu obroci, jela po izboru.',
 E'Pon–Pet: doručak 08:00–10:00, ručak 11:00–15:00\nSub, ned i praznici: zatvoreno',
 '/canteens/manducat.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/restoran-manducat', true),

(7, 'Gaudeamus', 'Restoran Gaudeamus', 'gaudeamus',
 'SEECEL, Ul. Radoslava Cimermana 88, Zagreb',
 null,
 E'Pon–Pet: doručak 08:00–10:00, ručak 11:00–14:00\nSub, ned i praznici: zatvoreno',
 '/canteens/gaudeamus.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/restoran-gaudeamus', true),

(8, 'Ekonomija (EFZG)', 'Restoran Ekonomskog fakulteta', 'ekonomija',
 'Trg J. F. Kennedyja 6, Zagreb',
 'Menu obroci, jela po izboru.',
 E'Pon–Pet: 08:00–15:00\nSub–Ned: zatvoreno',
 '/canteens/ekonomija.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/restoran-ekonomskog-fakulteta', true),

(9, 'RGNF-PBF', 'Restoran RGNF-PBF', 'rgnf-pbf',
 'Pierottijeva ul. 6, Zagreb',
 'Menu obroci, jela po izboru, caffe bar.',
 E'Pon–Pet: 11:00–15:00\nSub, ned i praznici: zatvoreno',
 '/canteens/rgnf-pbf.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/rgnf-pbf', true),

(10, 'Medicina (Šalata)', 'Restoran na Medicinskom fakultetu', 'medicina',
 'Šalata 3b, Zagreb',
 'Menu obroci, jela po izboru.',
 E'Pon–Pet: ručak 11:00–15:00\nSub–Ned: zatvoreno',
 '/canteens/medicina.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/medicinski-fakultet', true),

(11, 'Filozofski (FFZG)', 'Restoran Filozofski fakultet', 'filozofski',
 'Ul. Ivana Lučića 3, Zagreb',
 'Menu obroci, jela po izboru.',
 E'Pon–Pet: 11:00–15:00\nSub, ned i praznici: zatvoreno',
 '/canteens/filozofski.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/filozofski-fakultet', true),

(12, 'Agronomija – Zeleni paviljon', 'Restoran Agronomija i Šumarstvo ZELENI PAVILJON', 'agronomija',
 'Ul. Tvrtka Miloša 1, Zagreb',
 'Menu obroci, jela po izboru, roštilj i pizza.',
 'Restoran trenutno ne radi.',
 '/canteens/agronomija.webp', 'https://www.sczg.unizg.hr/prehrana/restorani/agronomija-i-sumarstvo-zeleni-paviljon', false);
