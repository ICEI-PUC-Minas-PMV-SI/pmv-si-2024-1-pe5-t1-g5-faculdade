package com.example.faculdade_progressus.controllers;

import com.example.faculdade_progressus.models.Curso;
import com.example.faculdade_progressus.service.CursoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cursos")
public class CursoController {
    @Autowired
    private CursoService cursoService;

    @GetMapping
    public List<Curso> getAllCursos() {
        return cursoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Curso> getCursoById(@PathVariable Long id) {
        Curso curso = cursoService.findById(id);
        if (curso == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(curso);
    }

    @PostMapping
    public Curso createCurso(@RequestBody Curso curso) {
        return cursoService.save(curso);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Curso> updateCurso(@PathVariable Long id, @RequestBody Curso cursoDetails) {
        Curso curso = cursoService.findById(id);
        if (curso == null) {
            return ResponseEntity.notFound().build();
        }
        curso.setNome(cursoDetails.getNome());
        curso.setDescricao(cursoDetails.getDescricao());
        Curso updatedCurso = cursoService.save(curso);
        return ResponseEntity.ok(updatedCurso);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCurso(@PathVariable Long id) {
        Curso curso = cursoService.findById(id);
        if (curso == null) {
            return ResponseEntity.notFound().build();
        }
        cursoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
