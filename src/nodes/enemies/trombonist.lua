local Timer = require 'vendor/timer'
local sound = require 'vendor/TEsound'

return {
    name = 'trombonist',
    die_sound = 'trombone_temp',
    position_offset = { x = 0, y = 0 },
    height = 39,
    speed = 100,
    width = 58,
    damage = 2,
    hp = 8,
    vulnerabilities = {'stab'},
    tokens = 4,
    velocity = { x = 30, y = 0},
    tokenTypes = { -- p is probability ceiling and this list should be sorted by it, with the last being 1
        { item = 'coin', v = 1, p = 0.9 },
        { item = 'health', v = 1, p = 1 }
    },
    animations = {
        dying = {
            right = {'loop', {'1-4,1'}, 0.25},
            left = {'loop', {'1-4,2'}, 0.25}
        },
        default = {
            right = {'loop', {'4,1', '2-1,1'}, 0.25},
            left = {'loop', {'1,2', '3-4,2'}, 0.25}
        },
        following = {
            right = {'loop', {'4,1', '2-1,1'}, 0.25},
            left = {'loop', {'1,2', '3-4,2'}, 0.25}
        },
        hurt = {
            right = {'loop', {'4,1', '2-1,1'}, 0.25},
            left = {'loop', {'1,2', '3-4,2'}, 0.25}
        },
        dying = {
            right = {'loop', {'4,1', '2-1,1'}, 0.25},
            left = {'loop', {'1,2', '3-4,2'}, 0.25}
        }
    },
    enter = function( enemy )
        enemy.direction = math.random(2) == 1 and 'left' or 'right'
        enemy.maxx = enemy.position.x + 48
        enemy.minx = enemy.position.x - 48
    end,

    update = function( dt, enemy, player, level )
    if enemy.dead then return end

    local direction = enemy.direction == 'left' and 1 or -1
    if enemy.hp < 8 and math.abs(enemy.position.x - player.position.x) < 250 then 
            enemy.velocity.x = 90 * direction
            if math.abs(enemy.position.x - player.position.x) < 2 then
                --stay put
            elseif enemy.position.x < player.position.x then
                enemy.direction = 'right'
            elseif enemy.position.x + enemy.props.width > player.position.x + player.width then
                enemy.direction = 'left'
            end
    else                
            enemy.velocity.x = 40 * direction
            if enemy.position.x > enemy.maxx and enemy.state ~= 'attack' then
                    enemy.direction = 'left'
            elseif enemy.position.x < enemy.minx and enemy.state ~= 'attack'then
                    enemy.direction = 'right'
            end
    end


    end
    
}
