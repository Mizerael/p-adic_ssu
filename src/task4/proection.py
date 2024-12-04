import matplotlib.pyplot as plt
from typing import Callable


def f(x: int, mod: int) -> int:
    return (-7 - 17 * x + 3 * x ^ 2) % mod


g_r = 11
g_s = 15
g_ru = 12
g_su = 23


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
    f3 = x**2 + 30

    return (f1 ^ (2 * f2) ^ (4 * f3)) % mod


def draw_plots(k: int, fc: Callable[[int, int], int]) -> None:
    size = 2**k
    x = [i / size for i in range(size)]
    y = [fc(i, size) / size for i in range(size)]
    plt.scatter(x, y, s=2 ** (-k + 14), color="green")
    plt.title(f"k= {k}")
    pth = f"images/{fc.__name__}/{k}.png"
    plt.savefig(pth)
    print(f"{fc.__name__} с k={k} сохранено в {pth}")


def gcd(a: int, b: int) -> int:
    while b != 0:
        tmp = b
        b = a % b
        a = tmp
    return a


def draw_thor(g_r: int, g_s: int, g_ru: int, g_su: int, k: int) -> None:
    size = 2**k
    m = g_su / gcd(g_s, g_su)
    print(f"m= {m}")
    mult232 = 1
    c = g_r / g_s
    q = g_ru / g_su
    while 2**mult232 % m != 1:
        mult232 += 1
    print(f"Мультипликативный порядок = {mult232}")
    for i in range(mult232):
        print(
            f"z_{i} = {{y mod 1, ({g_r}/{g_s} * y + {-(2**i) * g_ru % g_su}/{g_su}) mod 1}}"
        )
    x = []
    y = [[] for _ in range(mult232)]
    for i in range(size):
        it = i / size * 50
        x.append(it % 1)
        for i in range(mult232):
            y[i].append((c * it + -(2**i) * q) % 1)
    for z in y:
        plt.scatter(x, z, s=1 / 2)
    plt.title("Обмотки тора для g")
    pth = "images/g/thor.png"
    plt.savefig(pth)
    print(f"g сохранено в {pth}")


def sol() -> None:
    for k in range(15, 21):
        draw_plots(k, f)
        draw_plots(k, h)
    draw_thor(g_r, g_s, g_ru, g_su, 15)


if __name__ == "__main__":
    sol()
