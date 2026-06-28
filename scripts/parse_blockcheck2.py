import sys
import os
from collections import deque

def parse_log_fast(input_file, output_file):
    if not os.path.exists(input_file):
        print(f"❌ Файл {input_file} не найден!")
        return
    
    buffer = deque(maxlen=2)

    with open(input_file, 'r', encoding='utf-8', errors='ignore') as infile, \
         open(output_file, 'w', encoding='utf-8') as outfile:
        outfile.write("==================================================\n")
        outfile.write("   СПИСОК РАБОЧИХ СТРАТЕГИЙ ПО ГРУППАМ BLOCKCHECK \n")
        outfile.write("==================================================\n\n")
                
        for line in infile:
            line_str = line.strip()
            if not line_str:
                continue

            if line_str.startswith("* script :"):
                outfile.write(f"\n{line_str}\n" + "-" * 50 + "\n")
                continue

            buffer.append(line_str)

            if "!!!!! AVAILABLE !!!!!" in line_str:
                if len(buffer) == 2:
                    strategy = buffer[0] 
                    if strategy.startswith("- "): 
                        strategy = strategy[2:] 
                    outfile.write(f"  {strategy}\n")

    print(f"🎉 Все готово! Результат сохранен в файл: {output_file}")

if __name__ == "__main__":
    # По умолчанию ищем стандартный blockcheck.log без двойки
    infile = sys.argv[1] if len(sys.argv) > 1 else "blockcheck2.log"
    outfile = sys.argv[2] if len(sys.argv) > 2 else "clean_summary.txt"
    parse_log_fast(infile, outfile)
