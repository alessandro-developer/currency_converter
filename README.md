# Currency Converter

---

# 🇬🇧 English

A Flutter app that displays exchange rates between currencies, with advanced state management and clean architecture.

---

## Index

1. [Requirements](#requirements)
2. [Architecture and Structure](#architecture-and-structure)
3. [How It Works](#how-it-works)
4. [Conclusions](#conclusions)

---

## Requirements

| Requirement | Satisfied | Notes |
|--------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------------------------------------------------------------------|
| Architecture with design pattern (MVVM, MVC, etc.) | ✅ | MVVM-like pattern with separation between presentation, business logic, and data layer. |
| Use of a state management library (bloc, riverpod, provider, etc.) | ✅ | Use of the `flutter_bloc` package for state management. |
| Use of the exchangerate-api.com API with provided key | ✅ | |
| Only USD endpoint: https://v6.exchangerate-api.com/v6/API_KEY/latest/USD | ✅ | |
| Local data persistence using a persistence library | ✅ | Use of the `shared_preferences` package via `CacheProvider` to save and load data. |
| Display of rates in a list or grid | ✅ | |
| Reference currency change without new API calls, algorithmic calculation | ✅ | Calculation is performed locally using already downloaded USD data, without new API calls. |
| UI state management: loading, success, error | ✅ | |
| Well-structured, clean, easily understandable code | ✅ | Clear folder structure, separation between layers, use of Cubit and well-defined models. |
| UI/UX not a priority, but a page with dropdown and list/grid is present | ✅ | |

---

## Architecture and Structure

This project adopts a **Clean Architecture** adapted to the Flutter context, where an **MVVM-like** (Model-View-ViewModel) approach and state management via **BLoC/Cubit** have been integrated:

- **Model (`lib/data/`)**: contains domain entities, data access logic, and data sources (API, local cache, etc.).
- **View (`lib/presentation/`)**: includes the User Interface, which interacts with Bloc/Cubit and updates based on the application state.
- **ViewModel (`lib/business_logic/`)**: implemented via Bloc/Cubit, acts as a mediator between View and Model, managing business logic and state.

This combination ensures a clear separation between presentation, business logic, and data access layers, guaranteeing testability, scalability, and maintainability.

**Singleton Pattern**

The classes [`CacheProvider`](lib/data/data_providers/local/cache_provider.dart), [`ExchangeRateProvider`](lib/data/data_providers/backend/exchange_rate_provider.dart), and [`ExchangeRateRepository`](lib/data/repositories/exchange_rate_repository.dart) are implemented as **Singletons**.  
This design choice ensures that only one instance of each provider/repository exists throughout the app's lifecycle, allowing:
- Efficient resource management (e.g., shared preferences, HTTP clients)
- Consistent access to cached data and API logic
- Avoidance of unnecessary object creation and memory usage

Singletons are especially useful in Flutter apps for services that must maintain a single state or cache, or that interact with device resources.

---

## How It Works

1. **Startup and data loading**
   - On app launch, the `ApiCallsCubit` calls two repository functions, which in turn query both the backend (API) and the local cache.
   - For each request, it checks if the data is already present in the cache:
     - If **present**, it reads from the cache.
     - If **absent**, it downloads from the API:
       - For exchange rates ([`getConversionRates`](lib/data/repositories/exchange_rate_repository.dart)), the download occurs **only once per day** at the first app launch.
       - For the list of supported currencies ([`getSupportedCodes`](lib/data/repositories/exchange_rate_repository.dart)), the download is **one-time** (static data, rarely changes).

2. **UI Initialization**
   - The "Amount" field is initially set to 1.
   - The currency menu is set to **USD - United States Dollar**.
   - The grid shows USD (value 1.00) in the first position, followed by all other currencies in alphabetical order.

3. **Amount modification**
   - If the user only changes the amount, the values in the grid automatically update based on the new amount.

4. **Reference currency modification**
   - If the user selects a different currency from the menu, the grid updates by showing the selected currency in the first position (with value 1.00) and all others in alphabetical order, with recalculated values.

5. **Combined modification of amount and currency**
   - If the user changes both the amount and the currency, the grid updates by showing the selected currency in the first position and all others in alphabetical order, with values calculated based on the data received from the cache.

6. **Value calculation**
   - The calculation of exchange rates between currencies is handled entirely on the client side, with no further API calls after the first fetch. The logic is implemented in the private function [`_calculateAndSortConversionRates`](lib/business_logic/cubits/home/home_cubit.dart):
   
   - **Logic explanation:**
      - It always starts from the downloaded and stored USD→X rates.
      - When the user changes the reference currency or amount:
        - It retrieves the USD→selected currency rate (`rateOfSelectedBaseToUSD`).
        - For each currency X, it calculates the rate relative to the selected currency using the formula:
          ```
          rate_selected_to_X = rate_USD_to_X / rate_USD_to_selected
          converted_value = rate_selected_to_X * amount
          ```
      - The results are sorted by showing the selected currency first, followed by the others in alphabetical order.
      - The state is updated via `emit`, updating the UI reactively.

   - **Reason for this choice:**
      - This solution allows **avoiding additional API calls**: all rates are calculated locally from already downloaded data.
      - **Consistency** is ensured among the displayed rates, as they all derive from the same daily snapshot.
      - The logic is **simple, efficient, and easily extendable** to any supported currency.

7. **UI Management**
   - The UI automatically manages loading, success, and error states, displaying messages where necessary.

---

## Conclusions

- **Requirements met:** All requirements are satisfied.
- **Clear architecture:** Clear separation between layers, easy to extend.
- **Robust state management:** Bloc/Cubit, reactive UI.
- **Efficient persistence:** Daily update, no unnecessary API calls.
- **Local rate calculation:** No API dependency after the first fetch.
- **Simple and functional UI:** Dropdown, amount field, rates grid, state management.

---
---

# 🇮🇹 Italiano

Un'app Flutter che mostra i tassi di cambio tra valute, con gestione avanzata dello stato e architettura pulita.

---

## Indice

1. [Requisiti](#requisiti)
2. [Architettura e Struttura](#architettura-e-struttura)
3. [Logica di Funzionamento](#logica-di-funzionamento)
4. [Conclusioni](#conclusioni)

---

## Requisiti

| Requisito | Soddisfatto | Note |
|--------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------------------------------------------------------------------|
| Architettura con design pattern (MVVM, MVC, ecc.) | ✅ | Pattern MVVM-like con separazione tra presentation, business logic e data layer. |
| Uso di una libreria di state management (bloc, riverpod, provider, ecc.) | ✅ | Utilizzo del package `flutter_bloc` per la gestione dello stato. |
| Uso dell’API exchangerate-api.com con chiave fornita | ✅ | |
| Solo endpoint USD: https://v6.exchangerate-api.com/v6/API_KEY/latest/USD | ✅ | |
| Persistenza locale dei dati tramite una libreria di persistenza | ✅ | Utilizzo del package `shared_preferences` tramite `CacheProvider` per salvare e caricare i dati. |
| Visualizzazione dei tassi in una lista o griglia | ✅ | |
| Cambio valuta di riferimento senza nuove chiamate API, calcolo algoritmico | ✅ | Il calcolo avviene localmente usando i dati USD già scaricati, senza nuove chiamate API. |
| Gestione degli stati UI: loading, success, error | ✅ | |
| Codice strutturato, pulito, facilmente comprensibile | ✅ | Struttura a cartelle chiara, separazione tra livelli, uso di Cubit e modelli ben definiti. |
| UI/UX non prioritaria, ma presente una pagina con dropdown e lista/griglia | ✅ | |

---

## Architettura e Struttura

Questo progetto adotta una **Clean Architecture** adattata al contesto Flutter, dove è stato integrato un approccio **MVVM-like** (Model-View-ViewModel) e la gestione dello stato tramite **BLoC/Cubit**:

- **Model (`lib/data/`)**: contiene le entità di dominio, la logica di accesso ai dati e le fonti dati (API, cache locale, ecc.).
- **View (`lib/presentation/`)**: comprende la User Interface, che interagisce con Bloc/Cubit e si aggiorna in base allo stato dell’applicazione.
- **ViewModel (`lib/business_logic/`)**: realizzato tramite Bloc/Cubit, funge da mediatore tra View e Model, gestendo la logica di business e lo stato.

Questa combinazione garantisce una chiara separazione tra livelli di presentazione, logica di business e accesso ai dati, assicurando testabilità, scalabilità e manutenibilità.

**Pattern Singleton**

Le classi [`CacheProvider`](lib/data/data_providers/local/cache_provider.dart), [`ExchangeRateProvider`](lib/data/data_providers/backend/exchange_rate_provider.dart) ed [`ExchangeRateRepository`](lib/data/repositories/exchange_rate_repository.dart) sono implementate come **Singleton**.  
Questa scelta progettuale garantisce che esista una sola istanza di ciascun provider/repository durante tutto il ciclo di vita dell’app, permettendo:
- Gestione efficiente delle risorse (es. shared preferences, HTTP client)
- Accesso coerente ai dati in cache e alla logica di API
- Evitare creazione inutile di oggetti e spreco di memoria

I Singleton sono particolarmente utili nelle app Flutter per servizi che devono mantenere uno stato unico o una cache, o che interagiscono con risorse di sistema.

---

## Logica di Funzionamento

1. **Avvio e caricamento dati**
   - All’apertura dell’app, l’`ApiCallsCubit` richiama due funzioni del repository, che a loro volta interrogano sia il backend (API) sia la cache locale.
   - Per ogni richiesta verifica se i dati sono già presenti in cache:
     - Se **presenti**, li legge dalla cache.
     - Se **assenti**, li scarica dall’API:
       - Per i tassi di cambio ([`getConversionRates`](lib/data/repositories/exchange_rate_repository.dart)), il download avviene **una sola volta al giorno** alla prima apertura dell’app.
       - Per la lista delle valute supportate ([`getSupportedCodes`](lib/data/repositories/exchange_rate_repository.dart)), il download è **unico** (dato statico, raramente cambia).

2. **Inizializzazione UI**
   - Il campo "Amount" è inizialmente impostato a 1.
   - Il menù valuta è impostato su **USD - United States Dollar**.
   - La griglia mostra al primo posto USD (valore 1.00), seguita da tutte le altre valute in ordine alfabetico.

3. **Modifica dell’importo**
   - Se l’utente modifica solo l’amount, i valori nella griglia si aggiornano automaticamente in base al nuovo importo.

4. **Modifica della valuta di riferimento**
   - Se l’utente seleziona una valuta diversa dal menù, la griglia si aggiorna mostrando la valuta scelta al primo posto (con valore 1.00) e tutte le altre in ordine alfabetico, con i valori ricalcolati.

5. **Modifica combinata di amount e valuta**
   - Se l’utente modifica sia l’importo che la valuta, la griglia si aggiorna mostrando al primo posto la valuta selezionata e tutte le altre in ordine alfabetico, con i valori calcolati in base ai dati ricevuti dalla cache.

6. **Calcolo dei valori**
   - Il calcolo dei tassi di cambio tra valute è gestito interamente lato client, senza ulteriori chiamate API dopo il primo fetch. La logica è implementata nella funzione privata [`_calculateAndSortConversionRates`](lib/business_logic/cubits/home/home_cubit.dart):
   
   - **Spiegazione della logica:**
      - Si parte sempre dai tassi USD→X scaricati e memorizzati.
      - Quando l’utente cambia valuta di riferimento o amount:
        - Si recupera il tasso USD→valuta selezionata (`rateOfSelectedBaseToUSD`).
        - Per ogni valuta X, si calcola il tasso rispetto alla valuta selezionata con la formula:
          ```
          rate_selected_to_X = rate_USD_to_X / rate_USD_to_selected
          valore_convertito = rate_selected_to_X * amount
          ```
      - I risultati vengono ordinati mostrando la valuta selezionata al primo posto, seguita dalle altre in ordine alfabetico.
      - Lo stato viene aggiornato tramite `emit`, aggiornando la UI in modo reattivo.

   - **Motivazione della scelta:**
      - Questa soluzione permette di **evitare chiamate API aggiuntive**: tutti i tassi sono calcolati localmente a partire dai dati già scaricati.
      - Si garantisce **consistenza** tra i tassi mostrati, perché tutti derivano dallo stesso snapshot giornaliero.
      - La logica è **semplice, efficiente e facilmente estendibile** a qualsiasi valuta supportata.

7. **Gestione UI**
   - La UI gestisce automaticamente gli stati di loading, successo ed errore, mostrando messaggi dove necessario.

---

## Conclusioni

- **Rispetto dei requisiti:** Tutti i requisiti sono rispettati.
- **Architettura chiara:** Separazione netta tra livelli, facile estensione.
- **Gestione stato robusta:** Bloc/Cubit, UI reattiva.
- **Persistenza efficiente:** Aggiornamento giornaliero, nessuna chiamata API superflua.
- **Calcolo tassi locale:** Nessuna dipendenza da API dopo il primo fetch.
- **UI semplice e funzionale:** Dropdown, campo importo, griglia tassi, gestione stati.

