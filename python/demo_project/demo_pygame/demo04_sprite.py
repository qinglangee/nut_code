import pygame
import random
import time

WIDTH = 560
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

all_sprites = pygame.sprite.Group()

y_speed = 0

# sprite extends Sprite
class Player(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.Surface((50, 50))
        self.image.fill(GREEN)
        self.rect = self.image.get_rect()
        self.rect.center = (WIDTH/2, HEIGHT/2)

    def update(self):
        self.rect.x += 5
        if self.rect.left > WIDTH:
            self.rect.right = 0
        self.rect.y += y_speed
        if self.rect.bottom < 0:
            self.rect.top = HEIGHT
        if self.rect.top > HEIGHT:
            self.rect.bottom = 0

player = Player()
all_sprites.add(player)


#Game loop
running = True
while running:
    # Process input (events)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_DOWN:
                y_speed = 3
            if event.key == pygame.K_UP:
                y_speed = -3
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                y_speed = 0

    # Update
    all_sprites.update()
    # Draw / Render
    screen.fill(WHITE)
    all_sprites.draw(screen)

    # *after* drawing everything, flip the display
    pygame.display.flip()
    clock.tick(FPS)

pygame.quit()