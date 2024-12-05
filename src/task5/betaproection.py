import matplotlib.pyplot as plt
from typing import Callable, Tuple, List


def int_fraction_to_bits(el: Tuple[int, int], deg: int, p: int) -> int:
    iterations = list()
    iterations.append(el)
    tmp_el = el
    res = 0
    for d in range(deg):
        for i in range(p):
            fl = False
            for j in range(-tmp_el[1], tmp_el[1]):
                if i * tmp_el[1] + p * j == tmp_el[0]:
                    # print(f"deg={d} bit_v={i} R={j} r={tmp_el[0]}")
                    tmp_el = (j, tmp_el[1])
                    fl = True
                    res += i << d
                    iterations.append(tmp_el)
                    break
            if fl:
                break

    return res


def f(x: int, k: int) -> int:
    return -7 - 17 * x + 3 * x**2


def it_g(x: int, c: int, q: int) -> int:
    return c * x + q


def g(x: int, k: int) -> int:
    return it_g(
        x,
        int_fraction_to_bits((11, 15), k, 2),
        int_fraction_to_bits((12, 23), k, 2),
    )


def to_bits(x: int, k) -> List[int]:
    res = []
    for _ in range(k):
        res.append(x % 2)
        x //= 2
    return res


def h(x: int, k: int) -> int:
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

    return f1 ^ (2 * f2) ^ (4 * f3)


def betaproection(fc, x, k, n) -> Tuple[int, int]:
    beta = 2 ** (1 / n)
    x_2 = to_bits(x, k)
    y_2 = to_bits(fc(x, k) % (2**k), k)
    ek_x = (sum(x_2[i] * (beta**i) for i in range(k)) / (beta**k)) % 1
    ek_y = (sum(y_2[i] * (beta**i) for i in range(k)) / (beta**k)) % 1
    return ek_x, ek_y


def draw_plots(k: int, n: int, fc: Callable[[int, int], int]) -> None:
    x = [i for i in range(2**k)]
    ek_x = []
    ek_y = []
    for x_i in x:
        x_beta, y_beta = betaproection(fc, x_i, k, n)
        ek_x.append(x_beta)
        ek_y.append(y_beta)

    plt.figure(figsize=(8, 8))
    plt.xlim(0, 1)
    plt.ylim(0, 1)
    plt.scatter(ek_x, ek_y, s=2 ** (-k + 14), color="green")
    plt.title(f"k= {k} n= {n}")
    pth = f"images/{fc.__name__}/{k}-{n}.png"
    plt.savefig(pth)
    plt.close()
    print(f"{fc.__name__} с k={k} n={n} сохранено в {pth}")


def sol() -> None:
    for k in range(15, 21):
        for n in range(50, 101, 10):
            draw_plots(k, n, f)
            draw_plots(k, n, h)
            draw_plots(k, n, g)


if __name__ == "__main__":
    sol()
