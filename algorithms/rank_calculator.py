import os
from supabase import create_client
from typing import List, Dict
from dataclasses import dataclass

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_ANON_KEY")
supabase = create_client(SUPABASE_URL, SUPABASE_KEY) if SUPABASE_URL else None

@dataclass
class SetData:
    carga: float
    reps: int

@dataclass
class ExerciseLog:
    ejercicio_id: str
    sets: List[SetData]
    body_weight: float

def calcular_rank(exercise_log: ExerciseLog, logs_por_semana: int) -> Dict:
    """Rank calculator - algoritmo de Symmetry adaptado."""
    if not exercise_log.sets:
        return {"rank": 0, "badge": "Novato 🪙"}
    volumen = sum(s.carga * s.reps for s in exercise_log.sets)
    frecuencia = logs_por_semana
    carga_max = max(s.carga for s in exercise_log.sets)
    intensidad = carga_max / exercise_log.body_weight if exercise_log.body_weight > 0 else 0
    score = (volumen * 0.4) + (frecuencia * 20) + (intensidad * 10)
    rank = min(score / 10, 100)
    return {"rank": round(rank, 2), "badge": determinar_badge(rank)}

def determinar_badge(rank: float) -> str:
    if rank >= 90: return "Titán 🥇"
    elif rank >= 70: return "Guerrero 🥈"
    elif rank >= 50: return "Héroe 🥉"
    elif rank >= 30: return "Guerrero Jr. 🛡️"
    else: return "Novato 🪙"

def calculate_user_ranks(user_id: str):
    """Fetch logs, calculate ranks, sync back to Supabase."""
    if not supabase:
        print("Supabase not configured")
        return
    logs = supabase.table("training_logs").select("*").eq("user_id", user_id).execute()
    for log in logs.data:
        for ej in log.get("ejercicios", []):
            sets = ej.get("sets", [])
            if sets:
                log_data = ExerciseLog(
                    ejercicio_id=ej["eid"],
                    sets=[SetData(carga=s["carga"], reps=s["reps"]) for s in sets],
                    body_weight=log.get("body_weight", 75)
                )
                weekly = supabase.table("training_logs").select("date").eq("user_id", user_id).eq("ejercicios", ej["eid"]).execute()
                rank_data = calcular_rank(log_data, len(weekly.data))
                supabase.table("ranks").upsert({
                    "user_id": user_id,
                    "exercise_id": ej["eid"],
                    "rank_score": rank_data["rank"],
                    "badge": rank_data["badge"],
                    "last_updated": "now()"
                }).execute()
                print(f"Updated rank: {ej['eid']} → {rank_data['rank']} {rank_data['badge']}")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        calculate_user_ranks(sys.argv[1])
