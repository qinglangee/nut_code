import pygame
import random
import time

WIDTH = 360
HEIGHT = 480
FPS = 30

BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)

# init and create window
pygame.init()
pygame.mixer.init() # 声音初始化
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("MyGame")
clock = pygame.time.Clock()

myfont = pygame.font.Font(None, 60)
textImage = myfont.render("pygame", True, WHITE)

count = 0
start = time.time()

#Game loop
running = True
while running:
    # Process input (events)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Update
    count += 1
    now = time.time()
    fps = count/(now - start)
    fps_image = myfont.render(str(fps), False, WHITE)

    # Draw / Render
    screen.fill(BLACK)
    screen.blit(fps_image, (10, 10))
    screen.blit(textImage, (10, 100))

    # *after* drawing everything, flip the display
    pygame.display.flip()
    clock.tick(FPS)

pygame.quit()