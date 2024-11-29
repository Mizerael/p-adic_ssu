from typing import List, Tuple
from math import log2


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


def convert_f_by_mod(poly_coefs: List[int | tuple], mod: int) -> List[int]:
    res = []
    for coef in poly_coefs:
        if isinstance(coef, tuple):
            res.append(int_fraction_to_bits(coef, int(log2(mod)), 2))
            continue
        res.append(coef & (mod - 1))
    return res


def calc_poly(poly_coefs: List[int], x: int, mod: int) -> int:
    res = 0
    for i in range(len(poly_coefs)):
        res += poly_coefs[i] * x**i
    return res % mod


def check_cycling(poly_cf: List[int], md: int) -> Tuple[bool, List[List[int]]]:
    gr = [x for x in range(md)]
    cycles = []
    while len(gr) > 0:
        new_cycle = [gr[0]]
        gr.remove(gr[0])
        next_el = calc_poly(poly_cf, new_cycle[-1], md)
        while next_el in gr:
            new_cycle.append(next_el)
            gr.remove(next_el)
            next_el = calc_poly(poly_cf, new_cycle[-1], md)
        if next_el != new_cycle[0]:
            cycles.append(new_cycle)
            return False, cycles
        cycles.append(new_cycle)
    return True, cycles


def poly_to_str(poly_cfs: List[int | tuple]) -> str:
    if isinstance(poly_cfs[0], tuple):
        res = f"{poly_cfs[0][0]}/{poly_cfs[0][1]}"
    else:
        res = str(poly_cfs[0])
    for i in range(1, len(poly_cfs)):
        tmp_el = poly_cfs[i]
        if isinstance(tmp_el, tuple):
            if tmp_el[0] < 0:
                res += f"{tmp_el[0]}/{tmp_el[1]}*x^{i}"
            else:
                res += f"+{tmp_el[0]}/{tmp_el[1]}*x^{i}"
        else:
            if tmp_el < 0:
                res += f"{tmp_el}*x^{i}"
            else:
                res += f"+{tmp_el}*x^{i}"
    return res


def check_biective(poly_cf: List[int | tuple]) -> Tuple[bool, str]:
    poly_cf_mod_4 = convert_f_by_mod(poly_cf, 4)
    status, _ = check_cycling(poly_cf_mod_4, 4)
    return (
        status,
        f"Функция {poly_to_str(poly_cf)} {''if status else 'не'}биективна",
    )


def check_transitive(poly_cf: List[int | tuple]) -> Tuple[bool, str]:
    poly_cf_mod_8 = convert_f_by_mod(poly_cf, 8)
    st, cycles = check_cycling(poly_cf_mod_8, 8)
    status = st & (len(cycles) == 1)
    return (
        status,
        f"Функция {poly_to_str(poly_cf)} {''if status else 'не'}транзитивна",
    )


def str_to_poly(f_str: str) -> List[int | tuple]:
    f_list = f_str.split()
    for i in range(len(f_list)):
        try:
            f_list[i] = int(f_list[i])
        except Exception:
            f_list[i] = tuple(map(int, f_list[i].split("/")))
    return f_list


def sol() -> None:
    print(f"Вариант {30 % 20 + 1}")
    f_x = input("Введите коэффициенты полинома f:")
    f_x = str_to_poly(f_x)
    g_x = input("Введите коэффициенты полинома g:")
    g_x = str_to_poly(g_x)
    status, mess = check_biective(f_x)
    print(mess)
    if status:
        _, mess = check_transitive(f_x)
        print(mess)
    status, mess = check_biective(g_x)
    print(mess)
    if status:
        _, mess = check_transitive(g_x)
        print(mess)


if __name__ == "__main__":
    sol()
