# 🚀 Asteroid Miner - Kosmiczny Górnik

## 🎯 Podstawowe Założenia

- **Silnik:** LÖVE 2D (Love2D) - idealny do gier 2D w Lua
- **Perspektywa:** Top-down 2D
- **Rozmiar mapy:** 2000x2000 pikseli (scrollowana kamera)
- **Czas rozgrywki:** 15-30 minut na sesję

## 🛸 Mechaniki Podstawowe

### Sterowanie Statku

```lua
-- Fizyka realistyczna z momentum
- Strzałki/WASD: thrust w kierunkach
- Spacja: hamowanie
- Maksymalna prędkość: 200 px/s
- Przyspieszenie: 150 px/s²
- Tarcie kosmiczne: 0.95 (lekkie wyhamowanie)
```

### System Zasobów

**3 typy minerałów:**
- 🔵 **Żelazo** (częste) - 1 punkt wartości
- 🟡 **Złoto** (rzadkie) - 5 punktów wartości  
- 💎 **Kryształy** (bardzo rzadkie) - 15 punktów wartości

### Asteroidy

- **3 rozmiary:** Małe (20px), Średnie (40px), Duże (60px)
- **Życie:** 1, 3, 5 hitów
- **Po zniszczeniu:** Rozpadają się na mniejsze + upuszczają zasoby
- **Spawn:** 50-80 asteroid na mapie

## ⚙️ Systemy Gry

### Ulepszenia Statku (5 poziomów każde)

1. **Silniki** - szybkość i przyspieszenie (+20% na poziom)
2. **Laser** - szybkość strzelania (+25% na poziom) 
3. **Ładownia** - pojemność zasobów (+10 jednostek na poziom)
4. **Tarcze** - punkty życia (+1 HP na poziom)

### Zagrożenia

- **Kolizje z asteroidami** - zadają 1 HP obrażeń
- **Statki piratów** (opcjonalnie) - pojawiają się po 5 minutach gry

### UI/HUD

- Pasek życia (3 HP na start)
- Licznik zasobów w ładowni
- Minimap/radar (150px promień)
- Menu ulepszeń (Tab)

## 🎨 Grafika i Efekty

### Grafika

- **Prostota:** Geometryczne kształty (trójkąty, koła)
- **Kolory:** Ciemne tło kosmosu, jasne obiekty
- **Rozmiar:** Statek 16x16px, UI skalowalne

### Efekty Cząsteczkowe

- Płomienie silników statku
- Eksplozje asteroid (10-15 cząsteczek)
- Błyski laserów
- Zbieranie zasobów (animacja ssania)

## 🏗️ Struktura Techniczna

### Pliki Projektu

```
asteroid_miner/
├── main.lua              -- Główna pętla gry
├── player.lua            -- Logika statku gracza
├── asteroid.lua          -- System asteroid
├── particle_system.lua   -- Efekty cząsteczkowe
├── ui.lua               -- Interface użytkownika
├── camera.lua           -- System kamery
├── collision.lua        -- Detekcja kolizji
└── conf.lua            -- Konfiguracja Love2D
```

### Stany Gry

1. **Menu główne**
2. **Gameplay** 
3. **Menu ulepszeń**
4. **Game Over**

## 🎲 Proceduralne Generowanie

- **Asteroid field:** Losowe pozycje z minimalną odległością
- **Typy minerałów:** Prawdopodobieństwo drop'u (70% żelazo, 25% złoto, 5% kryształy)
- **Rozmiary asteroid:** 50% małe, 35% średnie, 15% duże

## 🎯 Cele Rozgrywki

- **Przetrwanie:** Nie stracić wszystkich HP
- **Kolekcjonowanie:** Zebrać jak najwięcej zasobów
- **Progresja:** Ulepszyć statek do maksimum
- **Challenge:** Opcjonalny tryb "survival" z falami piratów

## 📊 Balans Gry

### Koszty Ulepszeń

| Poziom | Silniki | Laser | Ładownia | Tarcze |
|--------|---------|-------|----------|--------|
| 1      | 10      | 15    | 20       | 25     |
| 2      | 25      | 30    | 40       | 50     |
| 3      | 50      | 60    | 80       | 100    |
| 4      | 100     | 120   | 160      | 200    |
| 5      | 200     | 240   | 320      | 400    |

### Spawn Asteroid

- **Gęstość:** 1 asteroida na 2500 px²
- **Minimalna odległość:** 100px od gracza na start
- **Regeneracja:** Nowe asteroidy pojawiają się co 30 sekund na brzegach mapy

## 🔧 Parametry Techniczne

### Wymagania Systemowe

- **Love2D:** Wersja 11.3+
- **RAM:** Minimum 64MB
- **Rozdzielczość:** 800x600 (skalowalne)
- **FPS:** 60 FPS target

### Optymalizacje

- **Culling:** Renderowanie tylko obiektów w zasięgu kamery
- **Object pooling:** Recykling cząsteczek i pocisków
- **Spatial partitioning:** Quad-tree dla kolizji (opcjonalnie)

---

**Szacowany czas tworzenia:** 
- Doświadczony programista: 10-15 godzin
- Początkujący: 20-30 godzin

**Poziom trudności:** Średni - dobry projekt do nauki podstaw game devu w Lua
