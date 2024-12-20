# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: alvapari <alvapari@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/06 00:12:53 by alvapari          #+#    #+#              #
#    Updated: 2024/10/06 23:19:32 by alvapari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME = so_long

MLXFLAGS = -ldl -lglfw -pthread -lm

CFLAGS  = -Wall -Wextra -Werror -g -I ./MLX42/include/MLX42/

# Para añadirlo make FSANITIZE_ADDRESS=1
ifdef FSANITIZE_ADDRESS
	CFLAGS += -fsanitize=address
endif

CC = gcc

MLX42 = ./MLX42/build/

LIBFT = ./include/libft/

SRC_DIR = src/

OBJ_DIR = obj/

SRC_FILES = delete_imags_txtrs init_data init_paint main map_functions\
map_functions_four map_functions_three map_functions_two paint_functions\
paint_functions_two print_error_functions
SRC_DIR = src/
OBJ_DIR = obj/

SRC = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

all: $(NAME)

$(NAME): $(OBJ)
	@make -C $(LIBFT)
	@make -C $(MLX42)
	@$(CC) $(CFLAGS) $(OBJ) -L$(LIBFT) -lft -L$(MLX42) -lmlx42 $(MLXFLAGS) -o $(NAME)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -rf $(OBJ_DIR)
	@make clean -C $(MLX42)
	@make clean -C $(LIBFT)

fclean:
	@rm -rf $(OBJ_DIR)
	@rm -rf $(NAME)
	@make clean -C $(MLX42)
	@make fclean -C $(LIBFT)

re: fclean all

.PHONY: all clean fclean re
