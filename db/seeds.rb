# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# +++++++++++++++++ Creo usuarios +++++++++++++++++

Person.delete_all
User.delete_all

person = Person.create(name: 'Daniela', email: 'dani.quiroz@gmail.com')
user = User.create(username: 'dani', password: 'dani', password_confirmation: 'dani', person_id: person.id, roles_mask: 1)

# +++++++++++++++++ Creo categorias +++++++++++++++++
Category.delete_all

electivo = Category.create(name: "Electivo")
obligatorio = Category.create(name: "Obligatorio")
optativo = Category.create(name: "Optativo")

# +++++++++++++++++ Creo carreras +++++++++++++++++
Career.delete_all

civil = Career.create(name: "Ingeniería Civil Informática")
ejecu = Career.create(name: "Ingeniería Ejecución Informática")

# +++++++++++++++++ Creo departamentos +++++++++++++++++
Department.delete_all

depa = Department.create(name: "Ingeniería Informática")

# +++++++++++++++++ Creo cursos +++++++++++++++++

Course.delete_all

cripto = Course.create( code: "CPS01", 
	name: "Criptografía y protocolos de seguridad", 
	version: "1.0", 
	description: "Manejar el concepto y la operación de protocolos de seguridad.", 
	category_id: electivo.id, 
	career_id: civil.id, 
	department_id: depa.id)

redes = Course.create( code: "RC01", 
	name: "Redes de comunicación", 
	version: "1.0", 
	description: "Curso de redes y comunicación", 
	category_id: obligatorio.id, 
	career_id: civil.id, 
	department_id: depa.id)

Content.delete_all
# creo los contenidos de cripto
cripto_1 = Content.create(course_id: cripto.id, number: 1, name: 'Introducción', parent_id: nil, type: "Topic")
cripto_2 = Content.create(course_id: cripto.id, number: 2, name: 'Conceptos básicos de criptografía', parent_id: nil, type: "Topic")
cripto_3 = Content.create(course_id: cripto.id, number: 3, name: 'Criptografía simétrica', parent_id: nil, type: "Topic")
cripto_4 = Content.create(course_id: cripto.id, number: 4, name: 'Estándar de criptografía avanzada', parent_id: nil, type: "Topic")
cripto_5 = Content.create(course_id: cripto.id, number: 5, name: 'Criptografía de clave pública', parent_id: nil, type: "Topic")
cripto_6 = Content.create(course_id: cripto.id, number: 6, name: 'Autenticación de mensajes', parent_id: nil, type: "Topic")
cripto_7 = Content.create(course_id: cripto.id, number: 7, name: 'Distribución de claves', parent_id: nil, type: "Topic")
cripto_8 = Content.create(course_id: cripto.id, number: 8, name: 'Seguridad Web', parent_id: nil, type: "Topic")
cripto_9 = Content.create(course_id: cripto.id, number: 9, name: 'Protocolos criptográficos', parent_id: nil, type: "Topic")

Content.create(course_id: cripto.id, number: 1, name: 'Servicios, mecanismos y ataques', parent_id: cripto_1.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Arquitectura de seguridad OSI', parent_id: cripto_1.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Modelos', parent_id: cripto_2.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Sistemas criptográficos', parent_id: cripto_2.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Técnicas clásicas', parent_id: cripto_3.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Cifrado bloque y DES', parent_id: cripto_3.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'AES', parent_id: cripto_4.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Cifradores simétricos contemporáneos', parent_id: cripto_4.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Principios de criptosistemas de clave pública', parent_id: cripto_5.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Diffie - Hellman', parent_id: cripto_5.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 3, name: 'RSA', parent_id: cripto_5.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 4, name: 'ECC', parent_id: cripto_5.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Código de autenticación de mensajes MAC', parent_id: cripto_6.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Funciones HASH', parent_id: cripto_6.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 3, name: 'HMAC', parent_id: cripto_6.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 4, name: 'Protocolos de autenticación', parent_id: cripto_6.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 5, name: 'Firmas digitales', parent_id: cripto_6.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Sistemas simétricos', parent_id: cripto_7.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'Sistema de clave pública', parent_id: cripto_7.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'IPSec', parent_id: cripto_8.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'SSL', parent_id: cripto_8.id, type: 'Subtopic')

Content.create(course_id: cripto.id, number: 1, name: 'Kerberos', parent_id: cripto_9.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 2, name: 'PGP', parent_id: cripto_9.id, type: 'Subtopic')
Content.create(course_id: cripto.id, number: 3, name: 'SET', parent_id: cripto_9.id, type: 'Subtopic')

# creo los contenidos de redes
redes_1 = Content.create(course_id: redes.id, number: 1, name: 'Introducción a los sistemas de comunicación', parent_id: nil, type: "Topic")
redes_2 = Content.create(course_id: redes.id, number: 2, name: 'Arquitectura de protocolos', parent_id: nil, type: "Topic")
redes_3 = Content.create(course_id: redes.id, number: 3, name: 'Nivel de enlace', parent_id: nil, type: "Topic")
redes_4 = Content.create(course_id: redes.id, number: 4, name: 'Nivel de red', parent_id: nil, type: "Topic")
redes_5 = Content.create(course_id: redes.id, number: 5, name: 'Redes de área local', parent_id: nil, type: "Topic")
redes_6 = Content.create(course_id: redes.id, number: 6, name: 'Nivel de transporte', parent_id: nil, type: "Topic")
redes_7 = Content.create(course_id: redes.id, number: 7, name: 'Arquitecturas TCP/IP y otras', parent_id: nil, type: "Topic")

Content.create(course_id: redes.id, number: 1, name: 'Redes de telecomunicación', parent_id: redes_1.id, type: 'Subtopic')

Content.create(course_id: redes.id, number: 1, name: 'Modelo TCP/IP', parent_id: redes_2.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 2, name: 'Modelo OSI', parent_id: redes_2.id, type: 'Subtopic')

Content.create(course_id: redes.id, number: 1, name: 'Servicio, Protocolos', parent_id: redes_3.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 2, name: 'Funciones, sincronización, control de flujo, control de errores', parent_id: redes_3.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 3, name: 'Técnicas FEC y ARQ', parent_id: redes_3.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 4, name: 'Códigos', parent_id: redes_3.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 5, name: 'HDLC (High Data Link Control)', parent_id: redes_3.id, type: 'Subtopic')

Content.create(course_id: redes.id, number: 1, name: 'Servicios, protocolos', parent_id: redes_4.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 2, name: 'Organización', parent_id: redes_4.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 3, name: 'Interconexión', parent_id: redes_4.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 4, name: 'Encaminamiento', parent_id: redes_4.id, type: 'Subtopic')

Content.create(course_id: redes.id, number: 1, name: 'OSI TP', parent_id: redes_6.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 2, name: 'TCP y UDP', parent_id: redes_6.id, type: 'Subtopic')

Content.create(course_id: redes.id, number: 1, name: 'Descripción general de redes TCP/IP', parent_id: redes_7.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 2, name: 'Encaminamiento en TCP/IP', parent_id: redes_7.id, type: 'Subtopic')
Content.create(course_id: redes.id, number: 3, name: 'IPV6', parent_id: redes_7.id, type: 'Subtopic')


# METADATOS
MetadataSchema.delete_all
general = MetadataSchema.create(name: 'General', parent_id: nil)
life_cycle = MetadataSchema.create(name: 'Life cycle', parent_id: nil)
educational = MetadataSchema.create(name: 'Educational', parent_id: nil)
rights = MetadataSchema.create(name: 'Rights', parent_id: nil)

# Metadatos generales
MetadataSchema.create(name: 'Title', parent_id: general.id)
MetadataSchema.create(name: 'Language', parent_id: general.id)
MetadataSchema.create(name: 'Description', parent_id: general.id)
MetadataSchema.create(name: 'Keyword', parent_id: general.id)
MetadataSchema.create(name: 'Coverage', parent_id: general.id)
MetadataSchema.create(name: 'Structure', parent_id: general.id)
MetadataSchema.create(name: 'Aggregation level', parent_id: general.id)
MetadataSchema.create(name: 'Identifier', parent_id: general.id)

# Metadatos ciclo de vida
MetadataSchema.create(name: 'Versions', parent_id: life_cycle.id)
MetadataSchema.create(name: 'Status', parent_id: life_cycle.id)
contribute = MetadataSchema.create(name: 'Contribute', parent_id: life_cycle.id)
MetadataSchema.create(name: 'Role', parent_id: contribute.id)
MetadataSchema.create(name: 'Entity', parent_id: contribute.id)
MetadataSchema.create(name: 'Date', parent_id: contribute.id)

# Metadatos educational
MetadataSchema.create(name: 'Interactivity Type', parent_id: educational.id)
MetadataSchema.create(name: 'Learning Resource Type', parent_id: educational.id)
MetadataSchema.create(name: 'Interactivity Level', parent_id: educational.id)
MetadataSchema.create(name: 'Semantic Density', parent_id: educational.id)
MetadataSchema.create(name: 'Intended End User Role', parent_id: educational.id)
MetadataSchema.create(name: 'Context', parent_id: educational.id)
MetadataSchema.create(name: 'Typical Age Range', parent_id: educational.id)
MetadataSchema.create(name: 'Difficulty', parent_id: educational.id)
MetadataSchema.create(name: 'Typical Learning Time', parent_id: educational.id)
MetadataSchema.create(name: 'Description', parent_id: educational.id)
MetadataSchema.create(name: 'Language', parent_id: educational.id)

# Metadatos rights
MetadataSchema.create(name: 'Cost', parent_id: rights.id)
MetadataSchema.create(name: 'Copy Right And Other Restrictions', parent_id: rights.id)
MetadataSchema.create(name: 'Description', parent_id: rights.id)