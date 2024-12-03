from typing import List, Tuple

N = 30


def h(x: int, mod: int) -> int:
    f1 = x ^ 1
    f2 = (
        x
        & (1 + 2 * x)
        & (3 + 4 * x)
        & (7 + 8 * x)
        & (15 + 16 * x)
        & (31 + 32 * x)
        & (63 + 64 * x)
    )
    f3 = x**2 + N

    return (f1 ^ (2 * f2) ^ (4 * f3)) % mod


def check_cycling(md: int) -> Tuple[bool, List[List[int]]]:
    gr = [x for x in range(md)]
    cycles = []
    while len(gr) > 0:
        new_cycle = [gr[0]]
        gr.remove(gr[0])
        next_el = h(new_cycle[-1], md)
        while next_el in gr:
            new_cycle.append(next_el)
            gr.remove(next_el)
            next_el = h(new_cycle[-1], md)
        if next_el != new_cycle[0]:
            cycles.append(new_cycle)
            return False, cycles
        cycles.append(new_cycle)
    return True, cycles


def check_transitive(mod: int) -> Tuple[bool, List[List[int]], str]:
    st, cycles = check_cycling(mod)
    status = st & (len(cycles) == 1)
    return (
        status,
        cycles,
        f"Функция {''if status else 'не'}транзитивна",
    )


def sol() -> None:
    _, cycles, mess = check_transitive(256)
    print(f"Получившаяся перестановка {cycles}\n{mess}")


if __name__ == "__main__":
    sol()
