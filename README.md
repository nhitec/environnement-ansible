# Environnement Ansible (N-HiTec)

Cet environnement Docker sert de **bac à sable** pour le développement et les tests des projets Ansible d’*N-HiTec*.  
Il simule une petite infrastructure avec trois machines virtuelles légères :

- **nhitec01** → nœud géré  
- **nhitec02** → nœud géré  
- **nhitec03** → nœud de contrôle (machine Ansible)

---
#### Architecture du repo
```bash
├── docker-compose.yaml
├── nhitec01
│   ├── Dockerfile
│   └── ssh-keys
│       └── nhitec03.pub
├── nhitec02
│   ├── Dockerfile
│   └── ssh-keys
│       └── nhitec03.pub
├── nhitec03
│   ├── ansible
│   │   ├── ansible.cfg
│   │   ├── inventory.yaml
│   │   └── playbooks
│   │       └── test.yaml
│   ├── Dockerfile
│   └── ssh-keys
│       ├── id_ed25519
│       └── id_ed25519.pub
├── README.md
├── run.sh
└── stop.sh
```

## 🚀 Démarrage rapide

1. Lancer l'environnement :
```
./run.sh
```
2. Nettoyer l'environnement :
```
./stop.sh
```

## 📂 Inventaire Ansible
Un inventaire minimal est fourni par défaut :
```yaml
control:
  hosts:
    localhost:
      ansible_connection: local

nodes:
  hosts:
    nhitec01:
      ansible_host: nhitec01
      ansible_user: ansible
      ansible_ssh_private_key_file: ~/.ssh/id_ed25519
    nhitec02:
      ansible_host: nhitec02
      ansible_user: ansible
      ansible_ssh_private_key_file: ~/.ssh/id_ed25519
```
#### Groupes défini

- **control** → machines qui orchestrent l’infrastructure (ici uniquement localhost dans nhitec03)
- **nodes** → machines gérées par Ansible (nhitec01 et nhitec02)

Grâce à cette organisation, vous pouvez cibler :
1. tous les hôtes :
```bash
ansible -m ping all
```
2. uniquement les nœuds :
```bash
ansible -m ping nodes
```
3. unquement les noeuds de contrôle :
```bash
ansible -m ping control
```

## 📜 Playbooks

Lorsque vous lancez l'environnement, vous arrivez directement sur le conteneur **nhitec03**.  
Le répertoire de travail par défaut est **`/ansible`**, qui correspond à un volume bindé sur le dossier **`nhitec03/ansible`** de votre machine hôte.

Tous vos fichiers relatifs à Ansible (inventaires, playbooks, rôles, collections, etc.) doivent être placés dans ce dossier côté hôte.  
Ils seront automatiquement accessibles dans le conteneur.

>Les playbooks n’ont pas besoin d’être rangés spécifiquement dans `nhitec03/ansible/playbooks`.  
> Vous pouvez organiser votre arborescence comme vous le souhaitez (par exemple : `roles/`, `playbooks/`, `group_vars/`, …).



## 🛠️ Notes pratiques
- L’utilisateur par défaut sur les nœuds est ansible, avec accès sudo sans mot de passe.

- L’authentification SSH se fait par clé (~/.ssh/id_ed25519)

- nhitec03 contient déjà Ansible et les outils nécessaires (client SSH, Python)

- Les conteneurs sont sur le même réseau Docker et se résolvent par leur nom de service (nhitec01, nhitec02, nhitec03)

## ⚠️ ATTENTION

L'hôte **nhitec03** n'a pas encore les fingerprints des autres hôtes. Il est, dans ce cas, nécessaire de lancer cette commande au lancement :
```
ssh-keyscan -H nhitec01 && ssh-keyscan -H nhitec02
```