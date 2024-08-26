FROM traefik:v3.1

# Копіюємо конфігураційний файл Traefik до образу
COPY traefik.yml /etc/traefik/traefik.yml

# Встановлюємо конфігураційний файл як аргумент запуску
CMD ["--configFile=/etc/traefik/traefik.yml"]