package com.example.faculdade_progressus.controllers;

import com.example.faculdade_progressus.dto.DisciplinaDTO;
import com.example.faculdade_progressus.models.Curso;
import com.example.faculdade_progressus.models.Disciplina;
import com.example.faculdade_progressus.service.CursoService;
import com.example.faculdade_progressus.service.DisciplinaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/disciplinas")
public class DisciplinaController {

    @Autowired
    private DisciplinaService disciplinaService;

    @Autowired
    private CursoService cursoService;

    @GetMapping
    public List<Disciplina> getAllDisciplinas() {
        return disciplinaService.findAll();
    }

    @PostMapping
    public Disciplina createDisciplina(@RequestBody DisciplinaDTO disciplinaDTO) {
        Curso curso = cursoService.findById(disciplinaDTO.getCursoId());
        Disciplina disciplina = new Disciplina();
        disciplina.setNome(disciplinaDTO.getNome());
        disciplina.setDescricao(disciplinaDTO.getDescricao());
        disciplina.setCurso(curso);
        return disciplinaService.save(disciplina);
    }

    @PutMapping("/{id}")
    public Disciplina updateDisciplina(@PathVariable Long id, @RequestBody DisciplinaDTO disciplinaDTO) throws Exception {
        Disciplina disciplina = disciplinaService.findById(id)
                .orElseThrow(() -> new Exception("Disciplina not found with id " + id));
        Curso curso = cursoService.findById(disciplinaDTO.getCursoId());
        disciplina.setNome(disciplinaDTO.getNome());
        disciplina.setDescricao(disciplinaDTO.getDescricao());
        disciplina.setCurso(curso);
        return disciplinaService.save(disciplina);
    }

    @DeleteMapping("/{id}")
    public void deleteDisciplina(@PathVariable Long id) throws Exception {
        Disciplina disciplina = disciplinaService.findById(id)
                .orElseThrow(() -> new Exception("Disciplina not found with id " + id));
        disciplinaService.delete(disciplina);
    }
}
