### Repo structure

    .
    ├── .github                  
    │   ├── workflows           # Github workflow for app deployment
    ├── app                    
    │   ├── app.py              # Flask app
    │   ├── Dockerfile          # Flask app dockerfile
    │   ├── requirements.txt    # App requirements
    ├── compose.yaml            # Docker compose file
    └── README.md


### Local usage

#### This app can run locally with docker compose which exposes it on http://localhost (port 80)
`docker compose up`