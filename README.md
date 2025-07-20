# MyCyberTool

## Objectif

L'objectif de ce projet est d'explorer les fonctionnalités possibles dans le domaine de la cybersécurité en utilisant le langage C.

## Sommaire

- [Objectif](#objectif)
- [Prérequis](#prérequis)
- [Cloner le dépôt Git](#cloner-le-dépôt-git)
- [Structure du projet](#structure-du-projet)
- [Utilisation](#utilisation)
- [Modules détaillés](#modules-détaillés)
- [Tests](#tests)
- [Nettoyage](#nettoyage)

## Prérequis

- gcc
- make
- libpcap-dev

## Cloner le dépôt Git

1. **Installer Git**

   - **Windows** : téléchargez l’installateur sur https://git-scm.com/download/win
   - **macOS** : `brew install git` (avec Homebrew) ou via le package officiel
   - **Linux** : `sudo apt-get install git` (Debian/Ubuntu) ou `sudo yum install git` (Fedora/CentOS)

2. **Cloner le dépôt**

   ```bash
   git clone https://github.com/SekaJason/MyCyberTool.git
   ```

## Structure du projet

L’arborescence du projet :

```
CyberToolbox/
├── src/         # Code source C de chaque module
├── include/     # Définitions des interfaces (headers)
├── obj/         # Fichiers objets (.o) générés
├── output/      # Résultats générés par les modules (.txt, .bin)
├── logs/        # Fichiers de log à analyser
├── tests/       # Données et scripts de test
├── Makefile     # Automatisation de la compilation
└── README.md    # Documentation du projet
```

## Utilisation

Lance l’exécutable `CyberToolbox` et sélectionne l’option correspondante :

1. **Sniffer**

   - Menu : `1`
   - Argument : `<interface>` (ex. `eth0` ou `lo`)
   - Exemple de sortie :
     ```
     [TCP] 192.168.0.1:443 → 192.168.0.2:55321
     ```

2. **Chiffrement / Déchiffrement**

   - Menu : `2`
   - Arguments : `<mode> <fichier> <clé>` (`e` pour encrypt, `d` pour decrypt)
   - Exemple :
     ```bash
     2 e secret.txt maCle123
     # Crée output/secret.txt.bin
     ```

3. **Analyse de logs**

   - Menu : `3`
   - Argument : `<fichier_log>` (ex. `logs/auth.log`)
   - Résultat :
     ```
     logs/analysis.csv
     ```

4. **Génération de rapport**

   - Menu : `4`
   - Crée un rapport global dans `output/rapport.txt`

## Modules détaillés

### Sniffer Réseau

- **Objectif** : Capturer et afficher les paquets TCP/UDP sur une interface.
- **Fichiers** : `src/sniffer.c`, `include/sniffer.h`
- **Extensions possibles** : filtre BPF dynamique, export PCAP

### Chiffrement / Déchiffrement

- **Objectif** : Chiffrer et déchiffrer un fichier texte avec une clé.
- **Fichiers** : `src/encrypt.c`, `include/encrypt.h`
- **Extensions possibles** : algorithme AES, hachage SHA256

### Analyse de logs SSH

Objectif : Détecter et compter les tentatives de connexion échouées à partir d’un fichier `.log` syslog.

Fichiers : `src/log_analyzer.c`, `include/log_analyzer.h`

Fonctionnement :

1. Lit un fichier de log brut (ex. `tests/auth_sample.log`).
2. Repère les lignes contenant « Failed password ».
3. Extrait les adresses IP et met à jour un compteur par IP.
4. Génère un dossier de sortie dédié (`output/logs_analysis/`) où l’on trouve :
   - `stats_summary.txt` : résumé texte des statistiques générales (nombre total de lignes analysées, nombre d’échecs).
   - `intrusion_report.txt` : rapport détaillé sur les tentatives d’intrusion détectées (plages horaires, IPs les plus actives).
   - `ip_list.csv` : liste formatée des IPs et de leur nombre d’échecs, facilement importable en tableur.

Extensions possibles : ban automatique via iptables, interface web, filtre par période, export JSON ou HTML.


## Tests

Place les fichiers d’exemple dans `tests/` :

- `tests/auth_sample.log` (extrait de log SSH)
- `tests/plain.txt` (texte à chiffrer)

Exécute :

```bash
./CyberToolbox sniff lo
./CyberToolbox encrypt e tests/plain.txt maCle
./CyberToolbox logs tests/auth_sample.log
```

## Nettoyage

Pour supprimer les objets, l’exécutable et les dossiers générés :

```bash
make clean
```