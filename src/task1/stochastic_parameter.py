from typing import List

VAR = 30
SHIFT = 47


def gcd(a: int, b: int) -> int:
    while b != 0:
        tmp = b
        b = a % b
        a = tmp
    return a


def gen_group(n: int) -> List[int]:
    return [x for x in range(0, n) if gcd(x, n) == 1]


def evolve_func(a: int, x: int, n: int) -> int:
    return a * x % n


def gen_orbits(a: int, n: int, gr: List[int]) -> List[List[int]]:
    Orbits = []
    while len(gr) > 0:
        new_oprbit = [gr[0]]
        gr.remove(gr[0])
        evolve = evolve_func(a, new_oprbit[-1], n)
        while evolve in gr:
            new_oprbit.append(evolve)
            gr.remove(evolve)
            evolve = evolve_func(a, new_oprbit[-1], n)
        Orbits.append(new_oprbit)
    return Orbits


def calc_R(orbit: list[int], group: list[int]) -> int:
    orbit.sort()
    return (
        sum(
            [
                (group.index(orbit[i]) - group.index(orbit[i + 1])) ** 2
                for i in range(len(orbit) - 1)
            ]
        )
        + (len(group) + group.index(orbit[0]) - group.index(orbit[-1])) ** 2
    )


def calc_beeR(R: int, T: int, phi: int) -> int:
    return R / (phi**2) * T


def sol() -> None:
    n = VAR % SHIFT + SHIFT
    while True:
        try:
            a = int(input(f"Введите параметр a(взаимно простой с {n}): "))
            if gcd(a, n) == 1:
                break
            print(f"{a} не взаимно простое с {n}")
        except Exception:
            print("Требуется целое число\n")
    G_n = gen_group(n)
    phi_n = len(G_n)
    print(f"Група для n = {n}:\n {G_n}")
    print(f"phi(n) = {phi_n}")
    orbits = gen_orbits(a, n, G_n.copy())
    print("Полученные орбиты:")
    for x in orbits:
        print(x)
    N_n = len(orbits)
    print(f"Количество орбит: {N_n}")
    T_n = phi_n // N_n
    print(f"Период орбит: {T_n}")
    R = calc_R(orbits[0].copy(), G_n)
    print(f"Параметр стохастичности R= {R}")
    s = calc_beeR(R, T_n, phi_n)
    print(f"Бинормализованный параметр стохастичности s = {s:.6f}")


if __name__ == "__main__":
    sol()
