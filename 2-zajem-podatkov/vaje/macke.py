import requests
import re
import os
import csv

###############################################################################
# Najprej definirajmo nekaj pomožnih orodij za pridobivanje podatkov s spleta.
###############################################################################

# definiratje URL glavne strani bolhe za oglase z mačkami
cats_frontpage_url = 'http://www.bolha.com/zivali/male-zivali/macke/'
# mapa, v katero bomo shranili podatke
cat_directory = 'cat_data'
# ime datoteke v katero bomo shranili glavno stran
frontpage_filename = 'frontpage.html'
# ime CSV datoteke v katero bomo shranili podatke
csv_filename = 'cat_data.csv'


def download_url_to_string(url):
    '''This function takes a URL as argument and tries to download it
    using requests. Upon success, it returns the page contents as string.'''
    try:
        # del kode, ki morda sproži napako
        r = requests.get(url)
    except requests.exceptions.ConnectionError:
        # koda, ki se izvede pri napaki
        print("Could not access page" + url)
        # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
        return ""
        #ne vrnemo nic, izprintamo da ni slo 
    # nadaljujemo s kodo če ni prišlo do napake
    return r.text


def save_string_to_file(text, directory, filename):
    '''Write "text" to the file "filename" located in directory "directory",
    creating "directory" if necessary. If "directory" is the empty string, use
    the current directory.'''
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as file_out:
        file_out.write(text)
    return None

# Definirajte funkcijo, ki prenese glavno stran in jo shrani v datoteko.


def save_frontpage(url, ime_datoteke):
    r = requests.get(url)
    with open(ime_datoteke, 'w', encoding='utf-8') as datoteka:
            datoteka.write(r.text)
            print('shranjeno!')
'''Save "cats_frontpage_url" to the file
"cat_directory"/"frontpage_filename"'''
    

###############################################################################
# Po pridobitvi podatkov jih želimo obdelati.
###############################################################################


def read_file_to_string(directory, filename):
     with open(filename, encoding='utf-8') as datoteka:
         return datoteka.read()
'''Return the contents of the file "directory"/"filename" as a string.'''

# Definirajte funkcijo, ki sprejme niz, ki predstavlja vsebino spletne strani,
# in ga razdeli na dele, kjer vsak del predstavlja en oglas. To storite s
# pomočjo regularnih izrazov, ki označujejo začetek in konec posameznega
# oglasa. Funkcija naj vrne seznam nizov.


def page_to_ads(directory, filename):
    '''Split "page" to a list of advertisement blocks.'''
    datoteka = read_file_to_string(directory, filename)
    seznam_oglasov = []
    oglas = r'<div class="ad.*?">' + r'.*?' + r'<div class="clear"></div>'
    for ujemanje in re.finditer(oglas, datoteka, re.DOTALL):
        nas_oglas = ujemanje.group(0)
        seznam_oglasov.append(nas_oglas)
    return seznam_oglasov

# Definirajte funkcijo, ki sprejme niz, ki predstavlja oglas, in izlušči
# podatke o imenu, ceni in opisu v oglasu.


vzorec = re.compile(
    r'<table><tr><td><a title=(?P<ime>\w+)'
    r'<div class="price">(?P<cena>.+?)</div>.*?'
    r'href=.*(?P<opis>.+?)<div class="additionalInfo">.*?' ,
    re.DOTALL)

def get_dict_from_ad_block(directory, filename):
    '''Build a dictionary containing the name, description and price
    of an ad block.'''
    seznam_oglasov = page_to_ads(directory, filename)
    podatki_oglasov = []
    for oglas in seznam_oglasov:
        for ujemanje in vzorec.finditer(oglas):
            podatki_oglasa = ujemanje.group(0)
            podatki_oglasov.append(podatki_oglasa)
    return podatki_oglasov

# Definirajte funkcijo, ki sprejme ime in lokacijo datoteke, ki vsebuje
# besedilo spletne strani, in vrne seznam slovarjev, ki vsebujejo podatke o
# vseh oglasih strani.


def ads_from_file(TODO):
    '''Parse the ads in filename/directory into a dictionary list.'''
    return TODO

###############################################################################
# Obdelane podatke želimo sedaj shraniti.
###############################################################################


def write_csv(fieldnames, rows, directory, filename):
    '''Write a CSV file to directory/filename. The fieldnames must be a list of
    strings, the rows a list of dictionaries each mapping a fieldname to a
    cell-value.'''
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)
    return None

# Definirajte funkcijo, ki sprejme neprazen seznam slovarjev, ki predstavljajo
# podatke iz oglasa mačke, in zapiše vse podatke v csv datoteko. Imena za
# stolpce [fieldnames] pridobite iz slovarjev.


def write_cat_ads_to_csv(TODO):
    return TODO
