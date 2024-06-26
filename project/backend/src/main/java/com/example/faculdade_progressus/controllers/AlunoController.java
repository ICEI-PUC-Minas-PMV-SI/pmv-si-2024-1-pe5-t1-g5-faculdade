package com.example.faculdade_progressus.controllers;

import com.example.faculdade_progressus.models.Aluno;
import com.example.faculdade_progressus.service.AlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/alunos")
public class AlunoController {
    @Autowired
    private AlunoService alunoService;

    @GetMapping
    public List<Aluno> getAllAlunos() {
        return alunoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Aluno> getAlunoById(@PathVariable Long id) {
        Aluno aluno = alunoService.findById(id);
        if (aluno == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(aluno);
    }

    @PostMapping
    public Aluno createAluno(@RequestBody Aluno aluno) {
        return alunoService.save(aluno);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Aluno> updateAluno(@PathVariable Long id, @RequestBody Aluno alunoDetails) {
        Aluno aluno = alunoService.findById(id);
        if (aluno == null) {
            return ResponseEntity.notFound().build();
        }
        aluno.setNome(alunoDetails.getNome());
        aluno.setCpf(alunoDetails.getCpf());
        aluno.setEmail(alunoDetails.getEmail());
        aluno.setDataNascimento(alunoDetails.getDataNascimento());
        Aluno updatedAluno = alunoService.save(aluno);
        return ResponseEntity.ok(updatedAluno);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAluno(@PathVariable Long id) {
        Aluno aluno = alunoService.findById(id);
        if (aluno == null) {
            return ResponseEntity.notFound().build();
        }
        alunoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

