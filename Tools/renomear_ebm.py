import os
import re
import shutil

# Pasta atual
ROOT = "."

# Pasta de saída
EXPORT = os.path.join(ROOT, "Export")

os.makedirs(EXPORT, exist_ok=True)

for arquivo in os.listdir(ROOT):

    if not arquivo.lower().endswith(".ebm"):
        continue

    # Extrai o nome da pasta do arquivo
    # event_message_qn06_160.ebm -> qn06
    m = re.search(r'_([A-Za-z0-9]+)_\d+\.ebm$', arquivo)

    if not m:
        print(f"Ignorado: {arquivo}")
        continue

    # Nome da pasta em MAIÚSCULO
    nome_pasta = m.group(1).upper()

    destino_pasta = os.path.join(EXPORT, nome_pasta)
    os.makedirs(destino_pasta, exist_ok=True)

    nome, _ = os.path.splitext(arquivo)

    # Nome do arquivo em MAIÚSCULO, mantendo .ebm minúsculo
    novo_nome = nome.upper() + ".ebm"

    origem = os.path.join(ROOT, arquivo)
    destino = os.path.join(destino_pasta, novo_nome)

    shutil.copy2(origem, destino)

    print(f"{arquivo} -> {destino}")

print("\nConcluído!")