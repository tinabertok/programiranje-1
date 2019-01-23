from functools import lru_cache

###############################################################################
# Napisite funkcijo [najdaljse_narascajoce_podazporedje], ki sprejme seznam in
# poisce najdaljse (ne strogo) narascajoce podzaporedje stevil v seznamu.
#
# Na primer: V seznamu [2, 3, 6, 8, 4, 4, 6, 7, 12, 8, 9] je najdaljse naj vrne
# rezultat [2, 3, 4, 4, 6, 7, 8, 9].
###############################################################################


def najdaljse_narascajoce_podzaporedje(sez):
		zaporedje = []
		for i in range(len(sez)):
				if sez[i] == min(sez[i :]):
						zaporedje.append(sez[i])
				else:
						pass
		return zaporedje


###############################################################################
# Nepreviden študent je pustil robotka z umetno inteligenco nenadzorovanega.
# Robotek želi pobegniti iz laboratorija, ki ga ima v pomnilniku
# predstavljenega kot matriko števil:
#   - ničla predstavlja prosto pot
#   - enica predstavlja izhod iz laboratorija
#   - katerikoli drugi znak označuje oviro, na katero robotek ne more zaplejati

# Robotek se lahko premika le gor, dol, levo in desno, ter ima omejeno količino
# goriva. Napišite funkcijo [pobeg], ki sprejme matriko, ki predstavlja sobo,
# začetno pozicijo in pa število korakov, ki jih robotek lahko naredi z
# gorivom, in izračuna ali lahko robotek pobegne. Soba ima vedno vsaj eno
# polje.
#
# Na primer za laboratorij:
# [[0, 1, 0, 0, 2],
#  [0, 2, 2, 0, 0],
#  [0, 0, 2, 2, 0],
#  [2, 0, 0, 2, 0],
#  [0, 2, 2, 0, 0],
#  [0, 0, 0, 2, 2]]
#
# robotek iz pozicije (3, 1) pobegne čim ima vsaj 5 korakov, iz pozicije (5, 0)
# pa v nobenem primeru ne more, saj je zagrajen.
###############################################################################

soba = [[0, 1, 0, 0, 2],
		[0, 2, 2, 0, 0],
		[0, 0, 2, 2, 0],
		[2, 0, 0, 2, 0],
		[0, 2, 2, 0, 0],
		[0, 0, 0, 2, 2]]


def pobeg(soba, pozicija, koraki):
	n = len(soba)
	m = len(soba[0])
	def pomozna(pozicija, koraki):
			(i, j) = pozicija
			if i >= n:
				return False
			elif j >= m:
				return False
			elif soba[i][j] == 1:
				return True
			elif koraki > 0 and soba[i][j] == 0:
				right = pomozna((i, j+1), koraki - 1)
				left = pomozna((i, j-1), koraki - 1)
				down = pomozna((i+1, j), koraki - 1)
				up = pomozna((i-1, j), koraki - 1)
				return right or left or down or up
			else:
				return False
	return pomozna(pozicija, koraki)

print(pobeg(soba, (3,1), 5))
print(pobeg(soba, (3,1), 8))


			
