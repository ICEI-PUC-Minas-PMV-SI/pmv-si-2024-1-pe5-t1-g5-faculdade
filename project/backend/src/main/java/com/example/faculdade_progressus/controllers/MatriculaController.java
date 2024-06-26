package com.example.faculdade_progressus.controllers;

import com.example.faculdade_progressus.models.Matricula;
import com.example.faculdade_progressus.service.MatriculaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/matriculas")
public class MatriculaController {
    @Autowired
    private MatriculaService matriculaService;

    @GetMapping
    public List<Matricula> getAllMatriculas() {
        return matriculaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Matricula> getMatriculaById(@PathVariable Long id) {
        Matricula matricula = matriculaService.findById(id);
        if (matricula == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(matricula);
    }

    @PostMapping
    public Matricula createMatricula(@RequestBody Matricula matricula) {
        return matriculaService.save(matricula);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Matricula> updateMatricula(@PathVariable Long id, @RequestBody Matricula matriculaDetails) {
        Matricula matricula = matriculaService.findById(id);
        if (matricula == null) {
            return ResponseEntity.notFound().build();
        }
        matricula.setAluno(matriculaDetails.getAluno());
        matricula.setDisciplina(matriculaDetails.getDisciplina());
        matricula.setDataMatricula(matriculaDetails.getDataMatricula());
        Matricula updatedMatricula = matriculaService.save(matricula);
        return ResponseEntity.ok(updatedMatricula);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMatricula(@PathVariable Long id) {
        Matricula matricula = matriculaService.findById(id);
        if (matricula == null) {
            return ResponseEntity.notFound().build();
        }
        matriculaService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
