# employee-costs-analytics-dbt
# Analytics Engineering Showcase: Employee Labor Costs dbt Project

Questo repository contiene un progetto dimostrativo di **Analytics Engineering** sviluppato per simulare la pipeline di modellazione dei costi aziendali (Costo del Lavoro e straordinari) utilizzando le migliori pratiche del **Modern Data Stack**.

## Obiettivo del Progetto
Dimostrare la transizione da un approccio di query SQL "artigianale" e script locali a un'architettura **modulare, versionata e testata** tramite **dbt** e **SQL avanzato**, simulando come target database **Google BigQuery**.

## Stack Tecnologico & Principi applicati
- **Modellazione dei Dati Modulare:** Architettura divisa in layer di *Staging*, *Intermediate* e *Marts* per garantire manutenibilità e riusabilità del codice.
- **SQL Avanzato:** Utilizzo sistematico di **CTE (Common Table Expressions)** per la leggibilità e di **Window Functions (`LAG()`, `PARTITION BY`)** per l'analisi dei trend mese su mese (MoM).
- **Data Quality (Testing):** Implementazione di test automatici (`unique`, `not_null`) a livello di schema dbt per intercettare anomalie nei dati prima del deploy in produzione.
- **DRY (Don't Repeat Yourself):** Utilizzo della funzione `ref()` di dbt per gestire la genealogia dei dati (Data Lineage) in modo dinamico.

## Struttura dei Modelli
1. **Staging (`models/staging/`)**: Pulizia dei dati grezzi provenienti dai sistemi HR, gestione dei tipi di dato e dei valori nulli.
2. **Intermediate (`models/intermediate/`)**: Layer per le logiche di business complesse (es. calcolo delle ore di straordinario con maggiorazione del 25%).
3. **Marts (`models/marts/`)**: Tabelle di fatto (`fct_`) pronte per essere consumate da strumenti di BI (es. Looker), arricchite con metriche di trend temporale.
