package com.jetbrains.kmm.androidApp.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.jetbrains.androidApp.R
import com.jetbrains.kmm.androidApp.MainActivity

import com.jetbrains.kmm.androidApp.model.endDateFormatted
import com.jetbrains.kmm.androidApp.model.startDateFormatted
import com.jetbrains.kmm.androidApp.utilities.ListAdapter
import com.jetbrains.kmm.shared.Network
import com.jetbrains.kmm.shared.model.Job
import kotlinx.android.synthetic.main.job_cell.view.*
import kotlinx.android.synthetic.main.jobs_fragment.*
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

class JobsFragments: Fragment() {

    private val mainScope = MainScope()

    private var adapter: ListAdapter<Job>? = null
    private lateinit var layoutManager: LinearLayoutManager

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.jobs_fragment, container, false)
    }

    override fun onStart() {
        super.onStart()

        adapter = ListAdapter(listOf(), R.layout.job_cell) { view, item ->
            updateCell(view, item)
        }

        layoutManager = LinearLayoutManager(requireContext())
        listView?.setHasFixedSize(true)
        listView?.layoutManager = layoutManager
        listView?.adapter = adapter

        setLoadingUIVisible(true)

        mainScope.launch {
            kotlin.runCatching {
                Network.getJobs()
            }.onSuccess {
                updateModel(it)
                setLoadingUIVisible(false)
            }.onFailure {
                Toast.makeText(requireActivity(), it.localizedMessage, Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun setLoadingUIVisible(visible: Boolean) {
        if (visible) {
            loadinView?.visibility = View.VISIBLE
        } else {
            loadinView?.visibility = View.GONE
        }
    }

    private fun updateModel(jobs: List<Job>) {
        adapter?.updateList(jobs)
    }

    private fun updateCell(view: ListAdapter.ViewHolder, item: Job) {
        view.view.titleLabel?.text = item.name
        view.view.typeLabel?.text = item.type.title
        view.view.fromDateLabel?.text = item.startDateFormatted
        view.view.toDateLabel?.text = item.endDateFormatted
        view.view.tasksStatusLabel?.text = item.tasksStatusFormatted
        view.view.progressBar?.progress = (item.taskStatusPercentage * 100).toInt()
        view.view.setOnClickListener {
            showJobDetail(item)
        }
    }

    private fun showJobDetail(job: Job) {
        val fragment = JobDetailFragment()
        fragment.job = job
        (requireActivity() as? MainActivity)?.pushFragment(fragment)
    }
}