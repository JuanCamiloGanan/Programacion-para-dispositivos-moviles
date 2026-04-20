package com.example.listadetareas

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.listadetareas.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val listaTareas = mutableListOf<Tarea>()
    private lateinit var adapter: TareaAdapter
    private var contadorId = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        configurarRecyclerView()
        configurarBotones()
    }

    private fun configurarRecyclerView() {
        //TODO 1
        adapter = TareaAdapter(listaTareas) { posicion ->
            eliminarTarea(posicion)
        }

        //TODO 2
        binding.rvTareas.layoutManager = LinearLayoutManager(this)

        //TODO 3
        binding.rvTareas.adapter = adapter
    }

    private fun configurarBotones() {
        binding.btnAgregar.setOnClickListener {
            val texto = binding.etNuevaTarea.text.toString().trim()
            if (texto.isNotEmpty()) {
                agregarTarea(texto)
                binding.etNuevaTarea.text.clear()
            } else {
                Toast.makeText(this, "Escribe una tarea primero", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun agregarTarea(titulo: String) {
        //TODO 4
        contadorId++

        //TODO 5
        val nuevaTarea = Tarea(contadorId, titulo, false)

        //TODO 6
        listaTareas.add(nuevaTarea)

        //TODO 7
        adapter.notifyItemInserted(listaTareas.size - 1)

        //TODO 8
        actualizarContador()
    }

    private fun eliminarTarea(posicion: Int) {
        //TODO 9
        listaTareas.removeAt(posicion)

        //TODO 10
        adapter.notifyItemRemoved(posicion)
        adapter.notifyItemRangeChanged(posicion, listaTareas.size)

        //TODO 11
        actualizarContador()
    }

    private fun actualizarContador() {
        //TODO 12
        val pendientes = listaTareas.count { !it.completada }

        //TODO 13
        binding.tvContador.text = "$pendientes tareas pendientes"
    }
}