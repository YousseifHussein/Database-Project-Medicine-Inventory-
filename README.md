# Medicine Inventory Database Project

## Project Overview
Contributing to the provision and facilitation of the sale of medicines
is one of the most important things that can be available to patients, so
this database is a model that fulfills this role. However, its pivotal role is
to facilitate the management of the medicine inventory, as doctors write
the medical prescription, then employees take the medicine out of the
designated area, then the invoice is calculated and presented to the patient,
and all of this is stored on a database like the one we have in our hands in
this project.

MySQL database to manage doctors, diseases, medicines, prescriptions, and billing.  
Includes tables with PK/FK constraints, a trigger for bill calculation, test data (≥10 rows/table), and sample queries.

## Repository Structure
- `DATABASE PROJECT.pdf` — Written report
- `Database Project Presentation.pptx` — Slides
- `medicine_inventory_project.sql` — Full SQL script (DDL + DML + trigger + queries)
- `README.md` — This file
- `video_link.txt` — Public link to the video walkthrough

> Note: If the instructor requires a `/sql/` folder split into `create_tables.sql`, `load_data.sql`, `queries.sql`, `triggers.sql`, you can split `medicine_inventory_project.sql` later into those files.

## How to Run
1. Open MySQL client (CLI or Workbench).
2. Execute the script:
   ```sql
   SOURCE /absolute/or/relative/path/to/medicine_inventory_project.sql;
