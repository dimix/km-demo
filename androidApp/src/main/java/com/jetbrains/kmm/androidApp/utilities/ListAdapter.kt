package com.jetbrains.kmm.androidApp.utilities

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

open class ListAdapter<T>(private var items: List<T>, val view: Int, val setupCell: ((ViewHolder, T) -> Unit)): RecyclerView.Adapter<ListAdapter.ViewHolder>()
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder
    {
        val v = LayoutInflater.from(parent.context).inflate(view, parent, false)
        return ViewHolder(v)
    }

    override fun getItemCount(): Int
    {
        return items.size
    }

    override fun onBindViewHolder(holder: ViewHolder, index: Int)
    {
        val invoice = items[index]
        setupCell(holder, invoice)
    }

    fun updateList(i: List<T>)
    {
        items = i

        notifyDataSetChanged()
    }

    class ViewHolder(val view: View) : RecyclerView.ViewHolder(view)
    {
    }
}