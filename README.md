# Medicine Inventory Database Project

## Project Overview
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
