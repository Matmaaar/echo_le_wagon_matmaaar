# Echo – Transformer l’apprentissage passif en apprentissage actif

**Echo** est une application web que j’ai conçue et développée initialement lors de ma formation au **Wagon**, puis améliorée et enrichie en version personnelle après la formation.  
Elle aide à mieux retenir et comprendre les contenus issus de **vidéos YouTube**, **podcasts**, et bientôt **PDF**.  
Elle transforme un simple visionnage ou écoute en un véritable apprentissage actif grâce à la génération de résumés, les quizz interactifs, la prise de notes avec timestamps et l’interaction intelligente avec l’IA — le tout simplement en collant l’URL de la vidéo ou du podcast.

## Captures d’écran

| Vue Index | Vue Show | Résumé |
|-----------|----------|--------|
| <img src="https://github.com/user-attachments/assets/7d9accbb-98c2-4344-b603-f3cf2b2a8de8" alt="Echo - Index" width="250" valign="top"/> | <img src="https://github.com/user-attachments/assets/e89d72a8-b8a1-4159-b031-c98124d7a02a" alt="Echo - Show" width="250" valign="top"/> | <img src="https://github.com/user-attachments/assets/166fb143-b2c8-4df9-8ac5-2ee4a37a8873" alt="Echo - Summary" width="250" valign="top"/> |

| Quizz | Chat IA | Notes avec timestamp |
|-------|---------|----------------------|
| <img src="https://github.com/user-attachments/assets/cc0b99f0-05f6-47f5-b2a1-8b4a054efcdc" alt="Echo - Quizz" width="250" valign="top"/> | <img src="https://github.com/user-attachments/assets/10c591e0-d361-4fab-afe9-3a535924e3cc" alt="Echo - AI chat" width="250" valign="top"/> | <img src="https://github.com/user-attachments/assets/bd6a8455-43a3-4cc2-b7c0-ff776fb22ce7" alt="Echo - Notes" width="250" valign="top"/> |


---

## Contexte

Ce projet a commencé comme travail d’équipe lors de ma formation en développement web (**Le Wagon**).  
Après la fin de la formation, j’ai continué seul à le développer, en ajoutant de nouvelles fonctionnalités et en améliorant l’architecture.  
L’objectif était de pousser mes compétences en **Ruby on Rails**, **API OpenAI**, **API Supadata** et intégration de services externes, tout en concevant un produit orienté utilisateur.  

Ce travail illustre :
- Ma capacité à faire évoluer un projet existant en solo.
- Mon autonomie dans l’apprentissage et l’implémentation de nouvelles fonctionnalités.
- Mon aptitude à livrer une application complète et exploitable.

---

## Fonctionnalités principales

- **Génération automatique de résumés** : Générés automatiquement à partir de la transcription pour résumer le contenu et expliquer les termes clés.
- **Quizz interactifs** : Générés automatiquement pour tester la compréhension et renforcer la mémoire.
- **Prise de notes avec timestamps** : Permet d’annoter le contenu et de retrouver facilement les passages importants.
- **Mode chatbot avancé (RAG)** : Posez des questions sur le contenu et obtenez des réponses précises grâce au *Retrieval-Augmented Generation*.
- **Version classique de prompt** : Accédez à un résumé ou à une synthèse ciblée.
- **Interface simple** : Il suffit de coller l’URL du contenu pour accéder instantanément à toutes ces fonctionnalités.
- **Langue personnalisable** : Choisissez la langue dans laquelle générer le résumé, le glossaire et les quizz.

---

## Stack technique

- **Framework** : Ruby on Rails
- **Back-end** : Ruby, Active Record
- **Front-end** : HTML, CSS, JavaScript (Rails views)
- **API** : 
  - **OpenAI** (version classique de prompt + version chatbot RAG)
  - **Supadata** (extraction et traitement de données issues de contenus multimédias)
- **Base de données** : PostgreSQL
- **Outils** : Git, GitHub

---

## Installation & utilisation

1. **Cloner le repo**  
   ```bash
   git clone https://github.com/<ton-github>/echo.git
   cd echo

2. **Installer les dépendances**
   ```bash
    bundle install
    yarn install

3. **Configurer les variables d’environnement**

Créer un fichier .env avec tes clés API :
   OPENAI_API_KEY=ta_clef_openai
   SUPADATA_API_KEY=ta_clef_supadata


4. Lancer le serveur

   ```bash
   rails db:create db:migrate
   rails server
   
L’application sera disponible sur http://localhost:3000.

## Points techniques clés ##

- Intégration de plusieurs APIs externes : OpenAI et Supadata.
- Gestion des prompts en deux modes : résumé classique et chat conversationnel RAG.
- Génération dynamique de quizz à partir du contenu.
- Système de prise de notes avec timestamps synchronisés sur la vidéo.
- Manipulation et traitement de données textuelles complexes.
- Architecture MVC propre et extensible.

## Améliorations prévues ##

- Ajout du support Spotify et PDF.
- Optimisation de l’interface pour desktop.
- Objectifs de complétion pour motiver l’utilisateur à consommer plus de contenu via l’app
- Ajout de tests unitaires et d’intégration (RSpec).

