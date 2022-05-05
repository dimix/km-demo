package com.jetbrains.kmm.androidApp.utilities

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

class VariableListAdapter<T>(var items: List<T>, val getViewType: (T)->Int, val setupCell: ((ViewHolder, T) -> Unit)): RecyclerView.Adapter<VariableListAdapter.ViewHolder>()
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder
    {
        val v = LayoutInflater.from(parent.context).inflate(viewType, parent, false)
        return ViewHolder(v)
    }

    override fun getItemViewType(position: Int): Int
    {
        val item = items[position]
        return getViewType(item)
    }

    override fun getItemCount(): Int
    {
        return items.size
    }

    override fun onBindViewHolder(holder: ViewHolder, index: Int)
    {
        val item = items[index]
        setupCell(holder, item)
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