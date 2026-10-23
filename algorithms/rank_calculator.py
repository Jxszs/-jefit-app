"""
Rank Calculator - Algoritmo para calcular ranks por ejercicio.
Robado del sistema de ranks de Symmetry + progresión científica.

Score = (volumen × 0.4) + (frecuencia × 20) + (intensidad × 10)
Rank = min(score / 10, 100)
"""

import numpy as np
from pydantic import BaseModel
from typing import List, Dict

class SetData(BaseModel):
    carga: float
    reps: int

class ExerciseLog(BaseModel):
    ejercicio_id: str
    sets: List[SetData]
    body_weight: float

def calcular_rank(exercise_log: ExerciseLog, ejercicio_id: str, logs_por_semana: int) -> Dict:
    """
    Calcula el rank de un ejercicio basado en progresos del usuario.
    """
    # Volumen = carga × reps × series
    volumen = sum(s.carga * s.reps for s in exercise_log.sets)

    # Frecuencia = cuántas veces a la semana
    frecuencia = logs_por_semana

    # Intensidad = carga máxima / body_weight
    carga_maxima = max(s.carga for s in exercise_log.sets) if exercise_log.sets else 0
    intensidad = carga_maxima / exercise_log.body_weight if exercise_log.body_weight > 0 else 0

    # Score total
    score = (volumen * 0.4) + (frecuencia * 20) + (intensidad * 10)

    # Normalizado a 0-100
    rank = min(score / 10, 100)

    return {
        "ejercicio_id": ejercicio_id,
        "rank": round(rank, 2),
        "badge": determinar_badge(rank)
    }

def determinar_badge(rank: float) -> str:
    """
    Badges robados del sistema de Symmetry.
    """
    if rank >= 90:
        return "Titán 🥇"
    elif rank >= 70:
        return "Guerrero 🥈"
    elif rank >= 50:
        return "Héroe 🥉"
    elif rank >= 30:
        return "Guerrero Jr. 🛡️"
    else:
        return "Novato 🪙"

# Ejemplo de uso
if __name__ == "__main__":
    log = ExerciseLog(
        ejercicio_id="sentadilla_id",
        sets=[SetData(carga=100, reps=10), SetData(carga=100, reps=8), SetData(carga=90, reps=12)],
        body_weight=75
    )
    result = calcular_rank(log, "sentadilla_id", 3)
    print(f"Rank: {result['rank']} | Badge: {result['badge']}")
