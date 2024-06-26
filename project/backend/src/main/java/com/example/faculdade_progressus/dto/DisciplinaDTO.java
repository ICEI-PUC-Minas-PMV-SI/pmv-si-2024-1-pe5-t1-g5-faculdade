package com.example.faculdade_progressus.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DisciplinaDTO {
    private Long id;
    private String nome;
    private String descricao;
    private Long cursoId;
}
