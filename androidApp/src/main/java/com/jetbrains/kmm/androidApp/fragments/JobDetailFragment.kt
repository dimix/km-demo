package com.jetbrains.kmm.androidApp.fragments


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment

import androidx.recyclerview.widget.LinearLayoutManager
import com.jetbrains.androidApp.R
import com.jetbrains.kmm.androidApp.model.endDateFormatted
import com.jetbrains.kmm.androidApp.model.startDateFormatted
import com.jetbrains.kmm.androidApp.utilities.VariableListAdapter
import com.jetbrains.kmm.shared.model.Job
import com.jetbrains.kmm.shared.model.Task
import kotlinx.android.synthetic.main.job_detail_fragment.*
import kotlinx.android.synthetic.main.job_detail_header_cell.view.*
import kotlinx.android.synthetic.main.job_detail_header_cell.view.fromDateLabel
import kotlinx.android.synthetic.main.job_detail_header_cell.view.toDateLabel
import kotlinx.android.synthetic.main.task_cell.view.*

class JobDetailFragment: Fragment() {
    sealed class Item {
        data class header(val job: Job) : Item()
        data class task(val task: Task) : Item()
    }

    private var adapter: VariableListAdapter<Item>? = null
    private lateinit var layoutManager: LinearLayoutManager
    lateinit var job: Job

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.job_detail_fragment, container, false)
    }

    override fun onStart() {
        super.onStart()

        adapter = VariableListAdapter(
            items = listOf(),
            getViewType = { item ->
                when (item) {
                    is Item.header -> {
                        R.layout.job_detail_header_cell
                    }
                    is Item.task -> {
                        R.layout.task_cell
                    }
                }
            },
            setupCell = { view, item ->
                when (item) {
                    is Item.header -> {
                        updateHeaderCell(view)
                    }
                    is Item.task -> {
                        updateTaskCell(view, item.task)
                    }
                }
            }
        )

        layoutManager = LinearLayoutManager(requireContext())
        listView?.setHasFixedSize(true)
        listView?.layoutManager = layoutManager
        listView?.adapter = adapter

        updateUI()
    }

    private fun updateUI() {
        val items = mutableListOf<Item>()

        items.add(Item.header(job))
        items.addAll(job.tasks.map { Item.task(it) })

        adapter?.updateList(items)
    }

    private fun updateHeaderCell(view: VariableListAdapter.ViewHolder,) {
        view.view.bodyLabel?.text = job.body
        view.view.fromDateLabel?.text = job.startDateFormatted
        view.view.toDateLabel?.text = job.endDateFormatted
        view.view.typeLabel?.text = job.type.title
    }

    private fun updateTaskCell(view: VariableListAdapter.ViewHolder, task: Task) {
        view.view.titleLabel?.text = task.name
        view.view.fromDateLabel?.text = task.startDateFormatted
        view.view.toDateLabel?.text = task.endDateFormatted
        view.view.timeLabel?.text = task.timePerDayFormatted
    }
}